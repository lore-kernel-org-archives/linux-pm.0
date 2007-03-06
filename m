From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: SATA resume slowness, e1000 MSI warning
Date: Tue, 06 Mar 2007 17:26:41 +0100
Message-ID: <1173198401.24738.340.camel@localhost.localdomain>
References: <20070225175559.GC12392@stusta.de>
	<20070227100202.GV3822@kernel.dk> <20070227102109.GG6745@elf.ucw.cz>
	<20070227103021.GA2250@kernel.dk> <20070227103407.GA17819@elte.hu>
	<20070227105922.GD2250@kernel.dk> <20070227111515.GA4271@kernel.dk>
	<20070301093450.GA8508@elte.hu> <20070302100704.GB2293@elf.ucw.cz>
	<20070305084257.GA4464@mellanox.co.il> <20070305101120.GA23032@elte.hu>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070305101120.GA23032@elte.hu>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Auke Kok <auke-jan.h.kok@intel.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, Pavel Machek <pavel@ucw.cz>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Andrew Morton <akpm@linux-foundation.org>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 2007-03-05 at 11:11 +0100, Ingo Molnar wrote:
> the spin-up takes a few seconds here under suspend/resume simulation:
> =

>  | ata1: waiting for device to spin up (7 secs)
>  | Restarting tasks ... done.
> =

>  [5-10 seconds pass]
> =

>  | ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>  | ata1.00: configured for UDMA/100
>  | SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
>  | sda: Write Protect is off
>  | sda: Mode Sense: 00 3a 00 00
>  | SCSI device sda: write cache: enabled, read cache: enabled, doesn't su=
pport DPO or FUA
> =

> with real resume it takes even longer time - but i dont see where the =

> delays come from in that case - i suspect it's SATA.

SATA has another nice feature. Somehow there is an interrupt pending on
the SATA controller, which comes in somewhere in the middle of resume.
If it happens before the SATA code resumed, the SATA code ignores the
interrupt and the interrupt is disabled due to "nobody cared", which in
turn prevents SATA to ever become functional again.

Any idea on that one ?

	tglx
