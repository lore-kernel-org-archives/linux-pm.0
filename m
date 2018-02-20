From: Ivid Suvarna <ivid.suvarna@gmail.com>
Subject: Timekeeping warning during resume from suspend to disk
Date: Tue, 20 Feb 2018 12:53:26 +0530
Message-ID: <CABXF_AAQVJ7eMt4gFhiEcgZTD7Y4R66-9ELZ1OJ2gAmKPeLMAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kernelnewbies-bounces+glkk-kernelnewbies=gmane.org@kernelnewbies.org>
List-Unsubscribe: <https://lists.kernelnewbies.org/mailman/options/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies/>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Errors-To: kernelnewbies-bounces+glkk-kernelnewbies=gmane.org@kernelnewbies.org
To: Kernel development list <linux-kernel@vger.kernel.org>, kernelnewbies@kernelnewbies.org, Linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi All,

Facing below warning backtrace during resume from suspend to disk. I
am using 4.1.15 freescale kernel. After this warning there is a huge
time gap (nearly 10 sec) between Enabling non-boot cpus and CPU1 being
up. Any pointers on this would be helpful.

[  545.227081] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  545.227081] [<80018674>] (unwind_backtrace) from [<80013c24>]
(show_stack+0x20/0x24)
[  545.227081] [<80013c24>] (show_stack) from [<80684220>]
(dump_stack+0x7c/0xbc)
[  545.227081] [<80684220>] (dump_stack) from [<80034fcc>]
(warn_slowpath_common+0x94/0xc4)
[  545.227081] [<80034fcc>] (warn_slowpath_common) from [<800350b8>]
(warn_slowpath_null+0x2c/0x34)
[  545.227081] [<800350b8>] (warn_slowpath_null) from [<8009ce24>]
(clockevents_program_event+0x14c/0x15c)
[  545.227081] [<8009ce24>] (clockevents_program_event) from
[<8009f39c>] (tick_resume_oneshot+0x5c/0x64)
[  545.227081] [<8009f39c>] (tick_resume_oneshot) from [<8009daa8>]
(tick_resume_local+0x58/0x68)
[  545.227081] [<8009daa8>] (tick_resume_local) from [<8009daf4>]
(tick_resume+0x1c/0x20)
[  545.227081] [<8009daf4>] (tick_resume) from [<80096328>]
(timekeeping_resume+0x1c8/0x2bc)
[  545.227081] [<80096328>] (timekeeping_resume) from [<803e5a7c>]
(syscore_resume+0x94/0x250)
[  545.227081] [<803e5a7c>] (syscore_resume) from [<800721b0>]
(suspend_devices_and_enter+0x78c/0x99c)
[  545.227081] [<800721b0>] (suspend_devices_and_enter) from
[<800728a0>] (pm_suspend+0x4e0/0x74c)
[  545.227081] [<800728a0>] (pm_suspend) from [<80070adc>]
(state_store+0x74/0xa0)
[  545.227081] [<80070adc>] (state_store) from [<8031f3c4>]
(kobj_attr_store+0x1c/0x28)
[  545.227081] [<8031f3c4>] (kobj_attr_store) from [<801a9814>]
(sysfs_kf_write+0x50/0x54)
[  545.227081] [<801a9814>] (sysfs_kf_write) from [<801a8fc8>]
(kernfs_fop_write+0xcc/0x1b8)
[  545.227081] [<801a8fc8>] (kernfs_fop_write) from [<8013c1d4>]
(__vfs_write+0x3c/0xec)
[  545.227081] [<8013c1d4>] (__vfs_write) from [<8013ca88>]
(vfs_write+0xa0/0x180)
[  545.227081] [<8013ca88>] (vfs_write) from [<8013d2fc>] (SyS_write+0x4c/0xa0)
[  545.227081] [<8013d2fc>] (SyS_write) from [<8000fd3c>]
(__cpuset_migrate_return+0x0/0x24)

Regards,
IVID
