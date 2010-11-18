From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: 2.6.37-rc2-git4: Reported regressions from 2.6.36
Date: Thu, 18 Nov 2010 18:52:43 -0500
Message-ID: <AANLkTimBJAKUEe3POB49DFSxqZzQAd03e_3Rn-0mP4wY__12162.8354107544$1290124532$gmane$org@mail.gmail.com>
References: <sKkKYVppECN.A.KhC.Phb5MB@chimera>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <sKkKYVppECN.A.KhC.Phb5MB@chimera>
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
Cc: Linux SCSI List <linux-scsi@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI <dri-devel@lists.freedesktop.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 18, 2010 at 6:23 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> This message contains a list of some regressions from 2.6.36,
> for which there are no fixes in the mainline known to the tracking team.
> If any of them have been fixed already, please let us know.
>
> If you know of any other unresolved regressions from 2.6.36, please let us
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
> =A02010-11-19 =A0 =A0 =A0 39 =A0 =A0 =A0 29 =A0 =A0 =A0 =A0 =A025
>
>
> Unresolved regressions
> ----------------------
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D23222
> Subject =A0 =A0 =A0 =A0 : 2.6.36 radeon KMS: [drm] Cannot find any crtc o=
r sizes
> Submitter =A0 =A0 =A0 : J=E1n Bedn=E1r <jan.bednar@gmail.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-11-18 15:33 (1 days old)
>

I've added a fix to that bug.

Alex

>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D23142
> Subject =A0 =A0 =A0 =A0 : autofs4 hang in 2.6.37-rc1
> Submitter =A0 =A0 =A0 : Avi Kivity <avi@redhat.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-11-14 12:55 (5 days old)
> Message-ID =A0 =A0 =A0: <4CDFDC2B.6040205@redhat.com>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1289739360=
26185&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D23122
> Subject =A0 =A0 =A0 =A0 : Regression in 2.6.37-rc1 for Intel 915 Graphics=
 Adapter - bisected to commit e9e331a
> Submitter =A0 =A0 =A0 : Larry Finger <Larry.Finger@lwfinger.net>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-11-11 1:47 (8 days old)
> Message-ID =A0 =A0 =A0: <4CDB4B1D.7000503@lwfinger.net>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1289440013=
11444&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D23102
> Subject =A0 =A0 =A0 =A0 : [bisected] i915 regression in post 2.6.36 kerne=
ls
> Submitter =A0 =A0 =A0 : Johannes Hirte <johannes.hirte@fem.tu-ilmenau.de>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-11-10 7:02 (9 days old)
> Message-ID =A0 =A0 =A0: <201011100802.20332.johannes.hirte@fem.tu-ilmenau=
.de>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1289373100=
17057&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D23092
> Subject =A0 =A0 =A0 =A0 : WARNING in tty_io.c
> Submitter =A0 =A0 =A0 : Shan Wei <shanwei@cn.fujitsu.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-11-10 8:06 (9 days old)
> Message-ID =A0 =A0 =A0: <4CDA5291.4010802@cn.fujitsu.com>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1289376451=
20159&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D23012
> Subject =A0 =A0 =A0 =A0 : ftdi_sio /dev/ttyUSB error: =A0"Resource Tempor=
arily Unavailable"
> Submitter =A0 =A0 =A0 : Kevin Smith <thirdwiggin@gmail.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-11-16 06:25 (3 days old)
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D22942
> Subject =A0 =A0 =A0 =A0 : [2.6.37-rc1, OOM] virtblk: OOM in do_virtblk_re=
quest()
> Submitter =A0 =A0 =A0 : Dave Chinner <david@fromorbit.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-11-05 1:30 (14 days old)
> Message-ID =A0 =A0 =A0: <20101105013003.GE13830@dastard>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1288920629=
17641&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D22912
> Subject =A0 =A0 =A0 =A0 : spi_lm70llp module crash on unload (2.6.37-rc1)
> Submitter =A0 =A0 =A0 : Randy Dunlap <randy.dunlap@oracle.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-11-05 0:16 (14 days old)
> Message-ID =A0 =A0 =A0: <20101104171620.00d8c95d.randy.dunlap@oracle.com>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1288916279=
13647&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D22882
> Subject =A0 =A0 =A0 =A0 : (2.6.37-rc1) amd64-agp module crashed on second=
 load
> Submitter =A0 =A0 =A0 : Randy Dunlap <randy.dunlap@oracle.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-11-05 0:13 (14 days old)
> Message-ID =A0 =A0 =A0: <20101104171333.fea1f498.randy.dunlap@oracle.com>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1288916052=
13447&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D22812
> Subject =A0 =A0 =A0 =A0 : kernel oops on 2.6.37-rc1
> Submitter =A0 =A0 =A0 : Andrew <atswartz@gmail.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-11-12 16:05 (7 days old)
> First-Bad-Commit: http://git.kernel.org/linus/a68c439b1966c91f0ef474e2bf2=
75d6792312726
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D22692
> Subject =A0 =A0 =A0 =A0 : [regression, 2.6.37-rc1] 'ip link tap0 up' stuc=
k in do_exit()
> Submitter =A0 =A0 =A0 : Dave Chinner <david@fromorbit.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-11-03 6:26 (16 days old)
> Message-ID =A0 =A0 =A0: <20101103062609.GB31163@dastard>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1288765601=
31870&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D22682
> Subject =A0 =A0 =A0 =A0 : [oops, 2.6.37-rc1] Unpacking initramfs failed, =
oops in free_init_pages()
> Submitter =A0 =A0 =A0 : Dave Chinner <david@fromorbit.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-11-03 1:54 (16 days old)
> Message-ID =A0 =A0 =A0: <20101103015427.GA31163@dastard>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1288749301=
19723&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D22672
> Subject =A0 =A0 =A0 =A0 : Regression in 2.6.37-rc1 for Intel 945 Graphics=
 Adapter - bisected to commit e9e331a
> Submitter =A0 =A0 =A0 : Larry Finger <Larry.Finger@lwfinger.net>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-11-11 01:56 (8 days old)
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D22652
> Subject =A0 =A0 =A0 =A0 : [drm:i915_gem_mmap_gtt_ioctl] *ERROR* Attemptin=
g to mmap a purgeable buffer
> Submitter =A0 =A0 =A0 : Tobias <devnull@plzk.org>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-11-10 21:59 (9 days old)
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D22642
> Subject =A0 =A0 =A0 =A0 : 2.6.37-rc1: Disk takes 10 seconds to resume - M=
acBook2,1
> Submitter =A0 =A0 =A0 : Tobias <devnull@plzk.org>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-11-10 19:33 (9 days old)
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D22572
> Subject =A0 =A0 =A0 =A0 : Linux 2.6.37-rc1 (acpi_video)
> Submitter =A0 =A0 =A0 : Randy Dunlap <randy.dunlap@oracle.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-11-02 18:51 (17 days old)
> Message-ID =A0 =A0 =A0: <20101102115106.bac57d21.randy.dunlap@oracle.com>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1288724039=
20449&w=3D2
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0http://marc.info/?l=3Dlinux-acpi&m=3D1=
28874714517914&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D22562
> Subject =A0 =A0 =A0 =A0 : Regression in 2.6.37-rc1 - logs spammed with "u=
nable to enumerate USB port" - bisected to commit 3df7169e
> Submitter =A0 =A0 =A0 : Larry Finger <Larry.Finger@lwfinger.net>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-11-02 22:32 (17 days old)
> First-Bad-Commit: http://git.kernel.org/linus/3df7169e73fc1d71a39cffeacc9=
69f6840cdf52b
> Message-ID =A0 =A0 =A0: <4CD09166.4060202@lwfinger.net>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1288737132=
07906&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D22552
> Subject =A0 =A0 =A0 =A0 : AMD boot freeze bisected to b126b4703afa4010b16=
1784a43650337676dd03b
> Submitter =A0 =A0 =A0 : Borislav Petkov <bp@amd64.org>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-11-02 17:03 (17 days old)
> First-Bad-Commit: http://git.kernel.org/linus/b126b4703afa4010b161784a436=
50337676dd03b
> Message-ID =A0 =A0 =A0: <20101102170335.GC24927@aftab>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1288717521=
09913&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D22542
> Subject =A0 =A0 =A0 =A0 : [2.6.37-rc1] drm:i195 errors
> Submitter =A0 =A0 =A0 : Paul Rolland <rol@witbe.net>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-11-02 14:58 (17 days old)
> Message-ID =A0 =A0 =A0: <20101102155813.09cb2c6e@tux.DEF.witbe.net>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1288709916=
28970&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D22532
> Subject =A0 =A0 =A0 =A0 : 2.6.37-rc1: BUG: scheduling while atomic (kvm_i=
nit)
> Submitter =A0 =A0 =A0 : Thomas Meyer <thomas@m3y3r.de>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-11-02 19:06 (17 days old)
> Message-ID =A0 =A0 =A0: <50AA24C585B14210A44AB599605C7CBD@hugo>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1288724799=
21559&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D22522
> Subject =A0 =A0 =A0 =A0 : 2.6.37-rc1 boot Problem - BUG: unable to handle=
 kernel null pointer - dmesg und config Datei
> Submitter =A0 =A0 =A0 : werner <w.landgraf@ru.ru>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-11-02 2:09 (17 days old)
> Message-ID =A0 =A0 =A0: <web-395697375@zbackend1.aha.ru>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1288663801=
10940&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D22472
> Subject =A0 =A0 =A0 =A0 : vga_switcheroo fails to switch from intel to ati
> Submitter =A0 =A0 =A0 : Radu Andries <admiral0@tuxfamily.org>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-11-08 16:46 (11 days old)
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D22282
> Subject =A0 =A0 =A0 =A0 : 2.6.37-rc1: WARNING..debugobjects: ODEBUG: free=
 active (active state 0) object type: percpu_counter
> Submitter =A0 =A0 =A0 : Randy Dunlap <randy.dunlap@oracle.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-11-01 21:58 (18 days old)
> Message-ID =A0 =A0 =A0: <4CCF37E8.1070208@oracle.com>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1288648793=
28429&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D22102
> Subject =A0 =A0 =A0 =A0 : [2.6.36-09452-g2d10d87] BUG: unable to handle k=
ernel NULL pointer dereference at (null)
> Submitter =A0 =A0 =A0 : Carlos R. Mafra <crmafra2@gmail.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-10-30 20:07 (20 days old)
> Message-ID =A0 =A0 =A0: <20101030200751.GA2866@Pilar.aei.mpg.de>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1288469358=
25136&w=3D2
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D22082
> Subject =A0 =A0 =A0 =A0 : 2.6.36-git11 -- kernel/pid.c:419 invoked rcu_de=
reference_check() without protection!
> Submitter =A0 =A0 =A0 : Miles Lane <miles.lane@gmail.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-10-29 5:22 (21 days old)
> Message-ID =A0 =A0 =A0: <AANLkTimGgzOZb8EwUQO16cZcL+ycveKTYzg_AAX+D+Kw@ma=
il.gmail.com>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1288329759=
24288&w=3D2
>
>
> Regressions with patches
> ------------------------
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D22962
> Subject =A0 =A0 =A0 =A0 : building (e)glibc against 2.6.37-rc1 headers fa=
ils
> Submitter =A0 =A0 =A0 : =A0<stephan@openelec.tv>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-11-15 00:09 (4 days old)
> Patch =A0 =A0 =A0 =A0 =A0 : https://bugzilla.kernel.org/show_bug.cgi?id=
=3D22962#c5
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D22932
> Subject =A0 =A0 =A0 =A0 : [REGRESSION] [2.6.37-rc1] Fan noise after suspe=
nd to ram/disk
> Submitter =A0 =A0 =A0 : Maciej Rutecki <maciej.rutecki@gmail.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-11-04 16:06 (15 days old)
> First-Bad-Commit: http://git.kernel.org/linus/3e384ee6c687cb397581ee8f944=
0fc8220cfac80
> Message-ID =A0 =A0 =A0: <201011041706.59046.maciej.rutecki@gmail.com>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1288886843=
08982&w=3D2
> Handled-By =A0 =A0 =A0: Rafael J. Wysocki <rjw@sisk.pl>
> Patch =A0 =A0 =A0 =A0 =A0 : https://bugzilla.kernel.org/attachment.cgi?id=
=3D37372
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D22722
> Subject =A0 =A0 =A0 =A0 : regression since 2.6.36: backlight in sony-lapt=
op not working
> Submitter =A0 =A0 =A0 : Norbert Preining <preining@logic.at>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-11-04 14:29 (15 days old)
> Message-ID =A0 =A0 =A0: <20101104142915.GC7650@gamma.logic.tuwien.ac.at>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1288880976=
00601&w=3D2
> Handled-By =A0 =A0 =A0: Mattia Dongili <malattia@linux.it>
> Patch =A0 =A0 =A0 =A0 =A0 : https://bugzilla.kernel.org/attachment.cgi?id=
=3D37442
>
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D22662
> Subject =A0 =A0 =A0 =A0 : divide error in select_task_rq_fair()
> Submitter =A0 =A0 =A0 : Myron Stowe <myron.stowe@hp.com>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2010-11-10 23:58 (9 days old)
> Patch =A0 =A0 =A0 =A0 =A0 : http://lkml.org/lkml/2010/11/13/176
>
>
> For details, please visit the bug entries and follow the links given in
> references.
>
> As you can see, there is a Bugzilla entry for each of the listed regressi=
ons.
> There also is a Bugzilla entry used for tracking the regressions from 2.6=
.36,
> unresolved as well as resolved, at:
>
> http://bugzilla.kernel.org/show_bug.cgi?id=3D21782
>
> Please let the tracking team know if there are any Bugzilla entries that
> should be added to the list in there.
>
> Thanks!
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
>
