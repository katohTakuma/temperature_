import launch
import launch.actions
import launch.substitutions
import launch_ros.actions


def generate_launch_description():

    talker = launch_ros.actions.Node(
        package='mypkg',      #パッケージの名前を指定
        executable='temperature',  #実行するファイルの指定
            output='screen'        #ログを端末に出すための設定
        )
    return launch.LaunchDescription([temperature, listener]) 
