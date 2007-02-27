From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: 2.6.21-rc1: known regressions (part 2)
Date: Tue, 27 Feb 2007 11:02:02 +0100
Message-ID: <20070227100202.GV3822@kernel.dk>
References: <Pine.LNX.4.64.0702202043280.4043@woody.linux-foundation.org>
	<20070225175559.GC12392@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20070225175559.GC12392@stusta.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-pm@lists.osdl.org, Thomas Gleixner <tglx@linutronix.de>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Daniel Walker <dwalker@mvista.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Feb 25 2007, Adrian Bunk wrote:
> This email lists some known regressions in 2.6.21-rc1 compared to 2.6.20
> that are not yet fixed in Linus' tree.
> =

> If you find your name in the Cc header, you are either submitter of one
> of the bugs, maintainer of an affectected subsystem or driver, a patch
> of you caused a breakage or I'm considering you in any other way possibly
> involved with one or more of these issues.
> =

> Due to the huge amount of recipients, please trim the Cc when answering.
> =

> =

> Subject    : ThinkPad T60: system doesn't come out of suspend to RAM
>              (CONFIG_NO_HZ)
> References : http://lkml.org/lkml/2007/2/22/391
> Submitter  : Michael S. Tsirkin <mst@mellanox.co.il>
>              Thomas Gleixner <tglx@linutronix.de>
> Handled-By : Ingo Molnar <mingo@elte.hu>
> Status     : unknown

x60 doesn't resume from S2R either, it doesn't matter if CONFIG_NO_HZ is
set or not though. 2.6.20 worked fine.

-- =

Jens Axboe
