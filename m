From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 2.6.39-rc5-git4: Reported regressions from 2.6.38
Date: Sat, 30 Apr 2011 13:50:04 -0700
Message-ID: <BANLkTik2L0BQ0cwOnWrgjyvxV4KMHkgaFQ__27697.0049286776$1304196692$gmane$org@mail.gmail.com>
References: <Xp4OiTz83N.A.O0D.JVGvNB@chimera>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Xp4OiTz83N.A.O0D.JVGvNB@chimera>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Alex Elder <aelder@sgi.com>, xfs@oss.sgi.com
Cc: Linux SCSI List <linux-scsi@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI <dri-devel@lists.freedesktop.org>, Florian Mickler <florian@mickler.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Sat, Apr 30, 2011 at 12:42 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>
> Bug-Entry =A0 =A0 =A0 : http://bugzilla.kernel.org/show_bug.cgi?id=3D34012
> Subject =A0 =A0 =A0 =A0 : 2.6.39-rc4+: oom-killer busy killing tasks
> Submitter =A0 =A0 =A0 : Christian Kujau <lists@nerdbynature.de>
> Date =A0 =A0 =A0 =A0 =A0 =A0: 2011-04-22 1:57 (9 days old)
> Message-ID =A0 =A0 =A0: <alpine.DEB.2.01.1104211841510.18728@trent.utfs.o=
rg>
> References =A0 =A0 =A0: http://marc.info/?l=3Dlinux-kernel&m=3D1303437446=
22331&w=3D2

Judging by the extended debug info in:

   http://nerdbynature.de/bits/2.6.39-rc4/oom/
   (The -9 files are the current ones)

that thing shows a _lot_ of xfs inodes:

  xfs_inode         479187 479187   1120   14    4 : tunables    0
0    0 : slabdata  34329  34329      0

even though there aren't that many dentries (each inode should have at
least one dentry associated with it under normal circumstances):

  dentry             97896  97900    160   25    1 : tunables    0
0    0 : slabdata   3916   3916      0

and then later when the system gets low on memory, the dentries shrink:

  dentry              1017   3525    160   25    1 : tunables    0
0    0 : slabdata    141    141      0

but the XFS inodes do not:

  xfs_inode         557579 557579   1120   14    4 : tunables    0
0    0 : slabdata  41492  41492      0

so I suspect it's some kind of XFS inode leak.

                      Linus
