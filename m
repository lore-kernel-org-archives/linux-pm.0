From: Andrew Hendry <andrew.hendry@gmail.com>
Subject: Re: 2.6.35-rc4-git3: Reported regressions from 2.6.34
Date: Fri, 9 Jul 2010 10:48:49 +1000
Message-ID: <AANLkTimAJBExF6Ld27cIjSH4H3vbXu6zRbien4IiJeR8__45080.9884038337$1278708275$gmane$org@mail.gmail.com>
References: <-IGZ64uxA6G.A.P0H.bLmNMB@chimera>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <-IGZ64uxA6G.A.P0H.bLmNMB@chimera>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: DRI <dri-devel@lists.sourceforge.net>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

Bug-Entry       : http://bugzilla.kernel.org/show_bug.cgi?id=3D16175
Subject         : 2.6.35-rc1 system oom, many processes killed but
memory not free
Submitter       : andrew hendry <andrew.hendry@gmail.com>
Date            : 2010-06-05 0:46 (34 days old)
Message-ID      : <AANLkTim7CiW-yfugZUAHZCqLvXKgt9CwolCvbLGdCLAk@mail.gmail=
.com>
References      : http://marc.info/?l=3Dlinux-kernel&m=3D127569877714937&w=
=3D2

Can be put down to bad ramdisk settings > actual memory, its probably
not a regression.
I think it can be closed for now, i'll do some testing and see if
ramdisk should complain before letting such configuration go through.


On Fri, Jul 9, 2010 at 9:33 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> This message contains a list of some regressions from 2.6.34,
> for which there are no fixes in the mainline known to the tracking team.
> If any of them have been fixed already, please let us know.
>
> If you know of any other unresolved regressions from 2.6.34, please let us
> know either and we'll add them to the list. =A0Also, please let us know
> if any of the entries below are invalid.
>
> Each entry from the list will be sent additionally in an automatic reply
> to this message with CCs to the people involved in reporting and handling
> the issue.
>
>
> Listed regressions statistics:
>
> =A0Date =A0 =A0 =A0 =A0 =A0Total =A0Pending =A0Unresolved
> =A0----------------------------------------
> =A02010-07-09 =A0 =A0 =A0 79 =A0 =A0 =A0 45 =A0 =A0 =A0 =A0 =A037
> =A02010-06-21 =A0 =A0 =A0 46 =A0 =A0 =A0 37 =A0 =A0 =A0 =A0 =A026
> =A02010-06-09 =A0 =A0 =A0 15 =A0 =A0 =A0 13 =A0 =A0 =A0 =A0 =A010
>
>
> Unresolved regressions
> ----------------------
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16353
> Subject =A0 =A0 =A0 =A0 : 2.6.35 regression
> Submitter =A0 =A0 =A0 : Zeev Tarantov <zeev.tarantov@gmail.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-07-05 13:04 (4 days old)
> Message-ID =A0 =A0 =A0: <loom.20100705T144459-919@post.gmane.org>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1278360027=
02522&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16346
> Subject =A0 =A0 =A0 =A0 : 2.6.35-rc3-git8 - include/linux/fdtable.h:88 in=
voked rcu_dereference_check() without protection!
> Submitter =A0 =A0 =A0 : Miles Lane <miles.lane@gmail.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-07-04 22:04 (5 days old)
> Message-ID =A0 =A0 =A0: <AANLkTinof0k28rk4rMr66aubxcRL2rFa5ZEArj1lqD3o@ma=
il.gmail.com>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1278281078=
15930&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16337
> Subject =A0 =A0 =A0 =A0 : general protection fault: 0000 [#1] SMP
> Submitter =A0 =A0 =A0 : Justin P. Mattock <justinmattock@gmail.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-07-03 22:59 (6 days old)
> Message-ID =A0 =A0 =A0: <4C2FC0E3.6050101@gmail.com>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1278197982=
15589&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16334
> Subject =A0 =A0 =A0 =A0 : reiserfs locking (v2)
> Submitter =A0 =A0 =A0 : Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-07-02 9:34 (7 days old)
> Message-ID =A0 =A0 =A0: <20100702093451.GA3973@swordfish.minsk.epam.com>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1278063063=
03590&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16333
> Subject =A0 =A0 =A0 =A0 : iwl3945: HARDWARE GONE??
> Submitter =A0 =A0 =A0 : Priit Laes <plaes@plaes.org>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-07-02 16:02 (7 days old)
> Message-ID =A0 =A0 =A0: <1278086575.2889.8.camel@chi>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1278086597=
05983&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16332
> Subject =A0 =A0 =A0 =A0 : Kernel crashes in tty code (tty_open)
> Submitter =A0 =A0 =A0 : werner@guyane.yi.org
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-07-02 3:34 (7 days old)
> Message-ID =A0 =A0 =A0: <1278041650.12788@guyane.yi.org>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1278041675=
11930&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16330
> Subject =A0 =A0 =A0 =A0 : Dynamic Debug broken on 2.6.35-rc3?
> Submitter =A0 =A0 =A0 : Thomas Renninger <trenn@suse.de>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-07-01 15:44 (8 days old)
> Message-ID =A0 =A0 =A0: <201007011744.19564.trenn@suse.de>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1277999072=
18877&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16329
> Subject =A0 =A0 =A0 =A0 : 2.6.35-rc3: Load average climbing to 3+ with no=
 apparent reason: CPU 98% idle, with hardly no I/O
> Submitter =A0 =A0 =A0 : T=F6r=F6k Edwin <edwintorok@gmail.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-07-01 7:40 (8 days old)
> Message-ID =A0 =A0 =A0: <20100701104022.404410d6@debian>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1277970050=
30536&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16324
> Subject =A0 =A0 =A0 =A0 : Oops while running fs_racer test on a POWER6 bo=
x against latest git
> Submitter =A0 =A0 =A0 : divya <dipraksh@linux.vnet.ibm.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-30 11:34 (9 days old)
> Message-ID =A0 =A0 =A0: <4C2B28F3.7000006@linux.vnet.ibm.com>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1277896973=
03061&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16323
> Subject =A0 =A0 =A0 =A0 : 2.6.35-rc3-git4 - kernel/sched.c:616 invoked rc=
u_dereference_check() without protection!
> Submitter =A0 =A0 =A0 : Miles Lane <miles.lane@gmail.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-07-01 12:21 (8 days old)
> Message-ID =A0 =A0 =A0: <AANLkTini6hz2LFeZi8CMUmY3xw1MU7NxmyesuxZ4oCdo@ma=
il.gmail.com>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1277986931=
25541&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16322
> Subject =A0 =A0 =A0 =A0 : WARNING: at /arch/x86/include/asm/processor.h:1=
005 read_measured_perf_ctrs+0x5a/0x70()
> Submitter =A0 =A0 =A0 : boris64 <bugzilla.kernel.org@boris64.net>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-07-01 13:54 (8 days old)
> Handled-By =A0 =A0 =A0: H. Peter Anvin <hpa@zytor.com>
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16312
> Subject =A0 =A0 =A0 =A0 : WARNING: at fs/fs-writeback.c:1127 __mark_inode=
_dirty
> Submitter =A0 =A0 =A0 : Zdenek Kabelac <zdenek.kabelac@gmail.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-28 9:40 (11 days old)
> Message-ID =A0 =A0 =A0: <AANLkTin24fr5O4_q5Xbo9Y_NKkEmtcp6Hgmr9_4qXaFz@ma=
il.gmail.com>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1277718048=
06465&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16311
> Subject =A0 =A0 =A0 =A0 : [REGRESSION][SUSPEND] 2.6.35-rcX won't suspend =
Lenovo W500 laptop
> Submitter =A0 =A0 =A0 : Shawn Starr <shawn.starr@rogers.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-28 0:45 (11 days old)
> Message-ID =A0 =A0 =A0: <201006272045.17004.shawn.starr@rogers.com>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1277686337=
05286&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16309
> Subject =A0 =A0 =A0 =A0 : 2.6.35-rc3 oops trying to suspend.
> Submitter =A0 =A0 =A0 : Andrew Hendry <andrew.hendry@gmail.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-27 12:40 (12 days old)
> Message-ID =A0 =A0 =A0: <AANLkTinUH2p33-AWxOVDrLsNkn9rgEVrlwn5mfK7P8NH@ma=
il.gmail.com>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1277642499=
26781&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16307
> Subject =A0 =A0 =A0 =A0 : i915 in kernel 2.6.35-rc3, high number of wakeu=
ps
> Submitter =A0 =A0 =A0 : Enrico Bandiello <enban@postal.uv.es>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-26 16:57 (13 days old)
> Message-ID =A0 =A0 =A0: <4C26317A.5070309@postal.uv.es>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1277574034=
04259&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16306
> Subject =A0 =A0 =A0 =A0 : 2.6.35-rc3 BUG: unable to handle kernel NULL po=
inter dereference at 0000000000000048 cifs_show_options
> Submitter =A0 =A0 =A0 : Andrew Hendry <andrew.hendry@gmail.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-26 10:46 (13 days old)
> Message-ID =A0 =A0 =A0: <AANLkTilhTrEBYZd4HxeXQk8B6-yV8rCJ2C0jXsEREgIR@ma=
il.gmail.com>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1277549221=
10501&w=3D2
> Handled-By =A0 =A0 =A0: Jeff Layton <jlayton@redhat.com>
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16304
> Subject =A0 =A0 =A0 =A0 : i915 - high number of wakeups
> Submitter =A0 =A0 =A0 : Enrico Bandiello <enban@postal.uv.es>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-27 09:52 (12 days old)
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16294
> Subject =A0 =A0 =A0 =A0 : [Q35 bisected] hang at init of i915 driver
> Submitter =A0 =A0 =A0 : Kees Cook <kees@outflux.net>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-25 18:20 (14 days old)
> First-Bad-Commit: http://git.kernel.org/linus/f1befe71fa7a79ab733011b0456=
39d8d809924ad
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16288
> Subject =A0 =A0 =A0 =A0 : kernel panic with iwlagn for Intel Wifi Link 51=
00
> Submitter =A0 =A0 =A0 : =A0<yanshuang.zheng@intel.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-25 08:14 (14 days old)
> Handled-By =A0 =A0 =A0: Reinette Chatre <reinette.chatre@intel.com>
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16284
> Subject =A0 =A0 =A0 =A0 : Hitting WARN_ON in hw_breakpoint code
> Submitter =A0 =A0 =A0 : Paul Mackerras <paulus@samba.org>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-23 12:57 (16 days old)
> Message-ID =A0 =A0 =A0: <20100623125740.GA3368@brick.ozlabs.ibm.com>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1277297891=
13432&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16265
> Subject =A0 =A0 =A0 =A0 : Why is kslowd accumulating so much CPU time?
> Submitter =A0 =A0 =A0 : Theodore Ts'o <tytso@mit.edu>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-09 18:36 (30 days old)
> First-Bad-Commit: http://git.kernel.org/linus/fbf81762e385d3d45acad057b65=
4d56972acf58c
> Message-ID =A0 =A0 =A0: <E1OMQ88-0002a1-Gb@closure.thunk.org>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1276108578=
19033&w=3D4
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16257
> Subject =A0 =A0 =A0 =A0 : sysfs changes break hwsim and bnep drivers
> Submitter =A0 =A0 =A0 : Johannes Berg <johannes@sipsolutions.net>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-20 11:23 (19 days old)
> References =A0 =A0 =A0: http://thread.gmane.org/gmane.linux.network/162754
> Handled-By =A0 =A0 =A0: Eric W. Biederman <ebiederm@xmission.com>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Kay Sievers <kay.sievers@vrfy.org>
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16234
> Subject =A0 =A0 =A0 =A0 : [2.6.35-rc3] reboot mutex 'bug'...
> Submitter =A0 =A0 =A0 : Daniel J Blueman <daniel.blueman@gmail.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-14 15:16 (25 days old)
> Message-ID =A0 =A0 =A0: <AANLkTimDcTnyEPmt2ZcCM1UWtn4AYKotiqyjobJApkO7@ma=
il.gmail.com>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1276528611=
18933&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16230
> Subject =A0 =A0 =A0 =A0 : inconsistent IN-HARDIRQ-W -> HARDIRQ-ON-W usage=
: fasync, 2.6.35-rc3
> Submitter =A0 =A0 =A0 : Dominik Brodowski <linux@dominikbrodowski.net>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-13 9:53 (26 days old)
> Message-ID =A0 =A0 =A0: <20100613095305.GA13231@comet.dominikbrodowski.ne=
t>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1276422822=
08277&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16228
> Subject =A0 =A0 =A0 =A0 : BUG/boot failure on Dell Precision T3500 (pci/a=
hci_stop_engine)
> Submitter =A0 =A0 =A0 : Brian Bloniarz <phunge0@hotmail.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-16 17:57 (23 days old)
> Handled-By =A0 =A0 =A0: Bjorn Helgaas <bjorn.helgaas@hp.com>
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16221
> Subject =A0 =A0 =A0 =A0 : 2.6.35-rc2-git5 -- [drm:drm_mode_getfb] *ERROR*=
 invalid framebuffer id
> Submitter =A0 =A0 =A0 : Miles Lane <miles.lane@gmail.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-11 20:31 (28 days old)
> Message-ID =A0 =A0 =A0: <AANLkTim0jVRyqkwlGOcrg_XTvUQwcBYfWJX-aRzkkrLG@ma=
il.gmail.com>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1276288281=
19623&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16205
> Subject =A0 =A0 =A0 =A0 : acpi: freeing invalid memtype bf799000-bf79a000
> Submitter =A0 =A0 =A0 : Marcin Slusarz <marcin.slusarz@gmail.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-09 20:09 (30 days old)
> Message-ID =A0 =A0 =A0: <20100609200910.GA2876@joi.lan>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1276114270=
29914&w=3D2
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0http://marc.info/?l=3Dlinux-kernel&m=
=3D127688398513862&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16201
> Subject =A0 =A0 =A0 =A0 : SIOCGIWFREQ ioctl fails to get frequency info
> Submitter =A0 =A0 =A0 : nuh <nuh@mailinator.net>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-14 10:45 (25 days old)
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16199
> Subject =A0 =A0 =A0 =A0 : 2.6.35-rc2-git1 - include/linux/cgroup.h:534 in=
voked rcu_dereference_check() without protection!
> Submitter =A0 =A0 =A0 : Miles Lane <miles.lane@gmail.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-07 18:14 (32 days old)
> Message-ID =A0 =A0 =A0: <AANLkTin2pPqOUx--9fIX3BH3e-cU6oCRufijcx_4ozx5@ma=
il.gmail.com>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1275934478=
12015&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16197
> Subject =A0 =A0 =A0 =A0 : [BUG on 2.6.35-rc2] sysfs: cannot create duplic=
ate filename '/devices/pci0000:00/0000:00:11.0/0000:02:03.0/slot'
> Submitter =A0 =A0 =A0 : Ryan Wang <openspace.wang@gmail.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-07 0:23 (32 days old)
> Message-ID =A0 =A0 =A0: <AANLkTincwMZPnYW3S4uz4k2GOn52RpgBIBRfzyD010Yo@ma=
il.gmail.com>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1275870222=
19378&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16187
> Subject =A0 =A0 =A0 =A0 : Carrier detection failed in dhcpcd when link is=
 up
> Submitter =A0 =A0 =A0 : Christian Casteyde <casteyde.christian@free.fr>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-12 15:15 (27 days old)
> First-Bad-Commit: http://git.kernel.org/linus/10708f37ae729baba9b67bd134c=
3720709d4ae62
> Handled-By =A0 =A0 =A0: Andrew Morton <akpm@linux-foundation.org>
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16184
> Subject =A0 =A0 =A0 =A0 : Container, X86-64, i386, iptables rule
> Submitter =A0 =A0 =A0 : Jean-Marc Pigeon <jmp@safe.ca>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-12 04:17 (27 days old)
> Handled-By =A0 =A0 =A0: Patrick McHardy <kaber@trash.net>
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16179
> Subject =A0 =A0 =A0 =A0 : 2.6.35-rc2 completely hosed on intel gfx?
> Submitter =A0 =A0 =A0 : Norbert Preining <preining@logic.at>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-06 11:55 (33 days old)
> Message-ID =A0 =A0 =A0: <20100606115534.GA9399@gamma.logic.tuwien.ac.at>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1275825349=
31581&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16175
> Subject =A0 =A0 =A0 =A0 : 2.6.35-rc1 system oom, many processes killed bu=
t memory not free
> Submitter =A0 =A0 =A0 : andrew hendry <andrew.hendry@gmail.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-05 0:46 (34 days old)
> Message-ID =A0 =A0 =A0: <AANLkTim7CiW-yfugZUAHZCqLvXKgt9CwolCvbLGdCLAk@ma=
il.gmail.com>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1275698777=
14937&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16173
> Subject =A0 =A0 =A0 =A0 : After uncompressing the kernel, at boot time, t=
he server hangs.
> Submitter =A0 =A0 =A0 : David Hill <hilld@binarystorm.net>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-09 23:25 (30 days old)
> First-Bad-Commit: http://git.kernel.org/linus/cf7500c0ea133d66f8449d86392=
d83f840102632
> Handled-By =A0 =A0 =A0: Eric W. Biederman <ebiederm@xmission.com>
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16145
> Subject =A0 =A0 =A0 =A0 : Unable to boot unless "notsc" or "clocksource=
=3Dhpet", or acpi_pad disabling the TSC
> Submitter =A0 =A0 =A0 : Tom Gundersen <teg@jklm.no>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-07 13:11 (32 days old)
> Handled-By =A0 =A0 =A0: Venkatesh Pallipadi <venki@google.com>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Len Brown <lenb@kernel.org>
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16122
> Subject =A0 =A0 =A0 =A0 : 2.6.35-rc1: WARNING at fs/fs-writeback.c:1142 _=
_mark_inode_dirty+0x103/0x170
> Submitter =A0 =A0 =A0 : Larry Finger <Larry.Finger@lwfinger.net>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-04 13:18 (35 days old)
> Handled-By =A0 =A0 =A0: Jens Axboe <axboe@kernel.dk>
>
>
> Regressions with patches
> ------------------------
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16310
> Subject =A0 =A0 =A0 =A0 : arm omap invalid module format
> Submitter =A0 =A0 =A0 : Robert Nelson <robertcnelson@gmail.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-28 17:30 (11 days old)
> First-Bad-Commit: http://git.kernel.org/linus/d0679c730395d0bde9a46939e7b=
a255b4ba7dd7c
> Handled-By =A0 =A0 =A0: Michal Marek <mmarek@suse.cz>
> Patch =A0 =A0 =A0 =A0 =A0 : https://bugzilla.kernel.org/attachment.cgi?id=
=3D26999
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16278
> Subject =A0 =A0 =A0 =A0 : lvm snapshot causes deadlock in 2.6.35
> Submitter =A0 =A0 =A0 : Phillip Susi <psusi@cfl.rr.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-23 16:55 (16 days old)
> Handled-By =A0 =A0 =A0: Eric Sandeen <sandeen@redhat.com>
> Patch =A0 =A0 =A0 =A0 =A0 : https://bugzilla.kernel.org/attachment.cgi?id=
=3D26933
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16271
> Subject =A0 =A0 =A0 =A0 : 2.6.35-rc3 regression: IBM Maia system is unboo=
table [ACPI related?]
> Submitter =A0 =A0 =A0 : James Bottomley <James.Bottomley@hansenpartnershi=
p.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-21 16:03 (18 days old)
> Message-ID =A0 =A0 =A0: <1277136189.10998.63.camel@mulgrave.site>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1277136228=
21166&w=3D2
> Handled-By =A0 =A0 =A0: Len Brown <len.brown@intel.com>
> Patch =A0 =A0 =A0 =A0 =A0 : https://patchwork.kernel.org/patch/108497/
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16256
> Subject =A0 =A0 =A0 =A0 : tpm_tis breaks suspend/hibernate on kernels > 2=
.6.34
> Submitter =A0 =A0 =A0 : Helmut Schaa <helmut.schaa@googlemail.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-20 11:15 (19 days old)
> First-Bad-Commit: http://git.kernel.org/linus/225a9be24d799aa16d543c31fb0=
9f0c9ed1d9caa
> Handled-By =A0 =A0 =A0: Helmut Schaa <helmut.schaa@googlemail.com>
> Patch =A0 =A0 =A0 =A0 =A0 : http://marc.info/?l=3Dtpmdd-devel&m=3D1276091=
60616162&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16255
> Subject =A0 =A0 =A0 =A0 : 2.6.35-rc3 deadlocks on semaphore operations
> Submitter =A0 =A0 =A0 : Christoph Lameter <cl@linux-foundation.org>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-18 14:49 (21 days old)
> Message-ID =A0 =A0 =A0: <alpine.DEB.2.00.1006180940140.11575@router.home>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1276872627=
27707&w=3D2
> Handled-By =A0 =A0 =A0: Manfred Spraul <manfred@colorfullife.com>
> Patch =A0 =A0 =A0 =A0 =A0 : http://marc.info/?l=3Dlinux-kernel&m=3D127731=
055203402&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16232
> Subject =A0 =A0 =A0 =A0 : 2.6.35-rc3 - WARNING:iwl_set_dynamic_key
> Submitter =A0 =A0 =A0 : Mario Guenterberg <mario.guenterberg@googlemail.c=
om>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-14 11:55 (25 days old)
> Message-ID =A0 =A0 =A0: <20100614115510.GA7904@guenti-laptop>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1276516956=
27147&w=3D2
> Handled-By =A0 =A0 =A0: Reinette Chatre <reinette.chatre@intel.com>
> Patch =A0 =A0 =A0 =A0 =A0 : http://article.gmane.org/gmane.linux.kernel.w=
ireless.general/52893
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16215
> Subject =A0 =A0 =A0 =A0 : sysfs: cannot create duplicate filename '/class=
/net/bnep0'
> Submitter =A0 =A0 =A0 : Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-06-15 14:55 (24 days old)
> Handled-By =A0 =A0 =A0: Eric W. Biederman <ebiederm@xmission.com>
> Patch =A0 =A0 =A0 =A0 =A0 : https://bugzilla.kernel.org/show_bug.cgi?id=
=3D16215#c10
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D16169
> Subject =A0 =A0 =A0 =A0 : Complain from preemptive debug
> Submitter =A0 =A0 =A0 : Sedat Dilek <sedat.dilek@googlemail.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-05-31 10:10 (39 days old)
> Message-ID =A0 =A0 =A0: <AANLkTilTnAAZIizKinYsxFkNTkrmPqk6XJJuUjjhJ7EP@ma=
il.gmail.com>
> References =A0 =A0 =A0: http://lkml.org/lkml/2010/5/31/77
> Handled-By =A0 =A0 =A0: Dmitry Monakhov <dmonakhov@openvz.org>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Sergey Senozhatsky <sergey.senozhatsky=
@gmail.com>
> Patch =A0 =A0 =A0 =A0 =A0 : http://www.spinics.net/lists/cpufreq/msg01631=
.html
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0https://patchwork.kernel.org/patch/106=
555/
>
>
> For details, please visit the bug entries and follow the links given in
> references.
>
> As you can see, there is a Bugzilla entry for each of the listed regressi=
ons.
> There also is a Bugzilla entry used for tracking the regressions from 2.6=
.34,
> unresolved as well as resolved, at:
>
> http://bugzilla.kernel.org/show_bug.cgi?id=3D16055
>
> Please let the tracking team know if there are any Bugzilla entries that
> should be added to the list in there.
>
> Thanks!
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
