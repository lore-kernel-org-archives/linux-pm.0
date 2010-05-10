From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: libata, hddtemp + s2ram is racy
Date: Mon, 10 May 2010 10:04:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005100958430.1626-100000__16628.0486774214$1273500309$gmane$org@iolanthe.rowland.org>
References: <20100507230732.5dd15e93@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100507230732.5dd15e93@neptune.home>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Cc: linux-ide@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 7 May 2010, Bruno [UTF-8] Pr=C3=A9mont wrote:

> Hi,
> =

> On a SMP system I've hit a race condition between suspend and hddtemp
> checking disk's temperature.
> =

> System details:
> - Dual-core AMD Turion CPU
> - 00:12.0 SATA controller [0106]: ATI Technologies Inc SB600 Non-Raid-5 S=
ATA [1002:4380]
> - hddtemp-0.3_beta15 (Gentoo package app-admin/hddtemp-0.3_beta15-r3)
> - Linus' tree shortly after v2.6.34-rc6, at commit
>   be1066bbcd443a65df312fdecea7e4959adedb45 with some drm updates on
>   top of it.
> =

> =

> It looked like hddtemp had sent the SMART request to disk right before
> suspend and during suspend process ata2 did complain without aborting
> suspend (see below).
> After resume access to that disk was dead-locked (any further
> attempt to suspend timed-out freezing hddtemp and any access attempt
> towards that disk did put userspace tasks in uninterruptible state and
> caused soft-raid to mark the disk failed).
> =

> Is suspend not waiting on SG_IO ioctls to complete (at ata host level)?

If you use the libata driver then the ATA I/O is handled by the SCSI =

midlayer.  The SCSI midlayer waits for the device's command queue to =

drain completely before initiating a suspend.

Furthermore, the hddtemp process has to get frozen before the suspend =

can begin, and I believe a process cannot be frozen while it is waiting =

for an SG_IO to complete.

At any rate, you should try posting this bug report on the linux-scsi =

mailing list.

Alan Stern
