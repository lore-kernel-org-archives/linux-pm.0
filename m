From: Mikko Vinni <mmvinni-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: uswsusp and plymouth don't play nice together
Date: Sun, 20 May 2012 23:52:19 -0700 (PDT)
Message-ID: <1337583139.52527.YahooMailNeo@web161806.mail.bf1.yahoo.com>
Reply-To: Mikko Vinni <mmvinni-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <plymouth-bounces+gcfp-plymouth=m.gmane.org-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/plymouth>,
	<mailto:plymouth-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/plymouth>
List-Post: <mailto:plymouth-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:plymouth-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/plymouth>,
	<mailto:plymouth-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Sender: plymouth-bounces+gcfp-plymouth=m.gmane.org-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Errors-To: plymouth-bounces+gcfp-plymouth=m.gmane.org-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
To: "plymouth-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <plymouth-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi,

has any uswsusp[1] (aka suspend-utils) or plymouth[2] developer tested the
two together? It seems there is a hang during resume from s2disk, and the
resume can be continued by pressing ALT-SysRq-K or ALT-SysRq-E.

This is not hardware specific neither new. For example, there is a bug repo=
rt
for Debian[3] opened in 2010 (don't get confused by the reference to the
blinking fb cursor bug). Personally, I have tested on Ubuntu 12.04 and
Arch Linux (stable and some rc kernel versions for some months now).
Easily reproduced also in a virtual machine, without graphical splash.

The hang does not occur if using the in-kernel hibernation, nor when
not starting plymouth before resume.

ALT-SysRq-T shows this backtrace for the 'plymouthd' and 'resume' processes:

[=A0=A0 51.853427] plymouthd=A0=A0=A0=A0=A0=A0 D 0000000000000000=A0=A0=A0=
=A0 0=A0=A0=A0 55=A0=A0=A0=A0=A0 1 0x00000004 =

[=A0=A0 51.853427]=A0 ffff88000da6fd18 0000000000000086 ffff88000da58000 ff=
ff88000da6ffd8 =

[=A0=A0 51.853427]=A0 ffff88000da6ffd8 ffff88000da6ffd8 ffff88000da59000 ff=
ff88000da58000 =

[=A0=A0 51.853427]=A0 0000000000000000 ffff88000da58490 ffff88000da6fc78 ff=
ff88000d9bd500 =

[=A0=A0 51.853427] Call Trace: =

[=A0=A0 51.853427]=A0 [<ffffffff8107d879>] ? finish_task_switch+0x49/0xd0 =

[=A0=A0 51.853427]=A0 [<ffffffff8145daa1>] ? __schedule+0x431/0x900 =

[=A0=A0 51.853427]=A0 [<ffffffff8145e0af>] schedule+0x3f/0x60 =

[=A0=A0 51.853427]=A0 [<ffffffff8109b9b3>] __refrigerator+0x43/0xe0 =

[=A0=A0 51.853427]=A0 [<ffffffff810bdb72>] ? cgroup_freezing+0x32/0x40 =

[=A0=A0 51.853427]=A0 [<ffffffff8106499d>] get_signal_to_deliver+0x56d/0x60=
0 =

[=A0=A0 51.853427]=A0 [<ffffffff8118687c>] ? destroy_inode+0x3c/0x70 =

[=A0=A0 51.853427]=A0 [<ffffffff81014278>] do_signal+0x68/0x750 =

[=A0=A0 51.853427]=A0 [<ffffffff811b04f1>] ? ep_poll+0x2a1/0x360 =

[=A0=A0 51.853427]=A0 [<ffffffff811b09ed>] ? sys_epoll_ctl+0xad/0x850 =

[=A0=A0 51.853427]=A0 [<ffffffff8116dfeb>] ? fput+0x16b/0x210 =

[=A0=A0 51.853427]=A0 [<ffffffff810149e5>] do_notify_resume+0x65/0x80 =

[=A0=A0 51.853427]=A0 [<ffffffff81460122>] int_signal+0x12/0x17
[=A0=A0 51.853427] resume=A0=A0=A0=A0=A0=A0=A0=A0=A0 S ffff88000da593c8=A0=
=A0=A0=A0 0=A0=A0=A0 57=A0=A0=A0=A0=A0 1 0x00000000 =

[=A0=A0 51.853427]=A0 ffff88000da5fd48 0000000000000082 ffff88000da59000 ff=
ff88000da5ffd8 =

[=A0=A0 51.853427]=A0 ffff88000da5ffd8 ffff88000da5ffd8 ffffffff8180d020 ff=
ff88000da59000 =

[=A0=A0 51.853427]=A0 ffff88000da59000 ffff88000da5ffd8 ffff88000da5ffd8 ff=
ff88000da5ffd8 =

[=A0=A0 51.853427] Call Trace: =

[=A0=A0 51.853427]=A0 [<ffffffff8108014c>] ? ttwu_do_wakeup+0x2c/0x120 =

[=A0=A0 51.853427]=A0 [<ffffffff8145eed8>] ? _raw_spin_unlock_irqrestore+0x=
38/0x50 =

[=A0=A0 51.853427]=A0 [<ffffffff8145e0af>] schedule+0x3f/0x60 =

[=A0=A0 51.853427]=A0 [<ffffffff812e20f7>] vt_event_wait+0xa7/0x130 =

[=A0=A0 51.853427]=A0 [<ffffffff81072570>] ? abort_exclusive_wait+0xb0/0xb0 =

[=A0=A0 51.853427]=A0 [<ffffffff812e225d>] vt_waitactive+0x2d/0x60 =

[=A0=A0 51.853427]=A0 [<ffffffff8145cc26>] ? mutex_lock+0x16/0x30 =

[=A0=A0 51.853427]=A0 [<ffffffff812e4886>] vt_move_to_console+0x56/0xc0 =

[=A0=A0 51.853427]=A0 [<ffffffff81094388>] pm_prepare_console+0x18/0x40 =

[=A0=A0 51.853427]=A0 [<ffffffff81095974>] hibernation_restore+0x14/0x130 =

[=A0=A0 51.853427]=A0 [<ffffffff8109afe8>] snapshot_ioctl+0x218/0x4a0 =

[=A0=A0 51.853427]=A0 [<ffffffff8117e787>] do_vfs_ioctl+0x97/0x530 =

[=A0=A0 51.853427]=A0 [<ffffffff8118ae14>] ? mntput+0x24/0x40 =

[=A0=A0 51.853427]=A0 [<ffffffff8116dfeb>] ? fput+0x16b/0x210 =

[=A0=A0 51.853427]=A0 [<ffffffff8117ecb9>] sys_ioctl+0x99/0xa0 =

[=A0=A0 51.853427]=A0 [<ffffffff8145fe69>] system_call_fastpath+0x16/0x1b =



Does plymouthd register to listen for console change, or something else
that it can't do while refrigerated?

There was on May 18th a patch proposed for the vt_event_wait() function[4],
but that patch has no effect for this particular hang.

Apparently Mandriva has a patch[5] to add plymouth support to uswsusp, but =
one
would assume that s2disk/resume should not hang in its default state.

Any ideas?


Mikko

--
[1] http://suspend.sourceforge.net/
[2] http://cgit.freedesktop.org/plymouth/
[3] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D593795
[4] "Race in vt_event_wait() during suspend/resume": http://article.gmane.o=
rg/gmane.linux.kernel/1299487
[5] changelog e.g.: http://rpmfind.net//linux/RPM/mandriva/2011/x86_64/medi=
a/main/release/suspend-0.8-12.20080612.x86_64.html
