From: "Kok, Auke" <auke-jan.h.kok@intel.com>
Subject: Re: SATA resume slowness, e1000 MSI warning
Date: Tue, 06 Mar 2007 09:09:30 -0800
Message-ID: <45EDA04A.1060500@intel.com>
References: <20070225175559.GC12392@stusta.de>
	<20070227100202.GV3822@kernel.dk>
	<20070227102109.GG6745@elf.ucw.cz>
	<20070227103021.GA2250@kernel.dk> <20070227103407.GA17819@elte.hu>
	<20070227105922.GD2250@kernel.dk> <20070227111515.GA4271@kernel.dk>
	<20070301093450.GA8508@elte.hu> <20070302100704.GB2293@elf.ucw.cz>
	<20070305084257.GA4464@mellanox.co.il>
	<20070305101120.GA23032@elte.hu>
	<1173198401.24738.340.camel@localhost.localdomain>
	<Pine.LNX.4.64.0703060845480.5963@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0703060845480.5963@woody.linux-foundation.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, Pavel Machek <pavel@ucw.cz>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Andrew Morton <akpm@linux-foundation.org>, Jeff Garzik <jgarzik@pobox.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

Linus Torvalds wrote:
> =

> On Tue, 6 Mar 2007, Thomas Gleixner wrote:
>> SATA has another nice feature. Somehow there is an interrupt pending on
>> the SATA controller, which comes in somewhere in the middle of resume.
>> If it happens before the SATA code resumed, the SATA code ignores the
>> interrupt and the interrupt is disabled due to "nobody cared", which in
>> turn prevents SATA to ever become functional again. >

> And if you don't want to do any of these things (or are unable to, becaus=
e =

> of some ordering constraint or bad design), then you simply need to =

> unregister and re-register the interrupt handler over sleep.
> =

>> Any idea on that one ?
> =

> Jeff, Auke, does this ring any bells?

For the e1000 issue, the problem is solved with Eric Biederman's 3-patch ms=
i =

cleanups. You should have another message in your mailbox confirming that I =

tested his patches and the MSI warning for e1000 suspend-resume is gone wit=
h them.

Cheers,

Auke
