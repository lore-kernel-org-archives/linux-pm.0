From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [3/6] 2.6.21-rc4: known regressions
Date: Wed, 28 Mar 2007 11:35:55 -0700
Message-ID: <20070328113555.c17bc1da.randy.dunlap@oracle.com>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
	<b6a2187b0703261046r46782eedv64464ceddb44bc27@mail.gmail.com>
	<1175065468.4017.1.camel@chaos>
	<200703281543.47049.maximlevitsky@gmail.com>
	<20070328180457.GA4253@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070328180457.GA4253@mellanox.co.il>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Cc: jgarzik@pobox.com, Maxim <maximlevitsky@gmail.com>, Jeff Chua <jeff.chua.linux@gmail.com>, linux-ide@vger.kernel.org, Torvalds <torvalds@linux-foundation.org>, gregkh@suse.de, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len@smtp.osdl.org, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Jens Axboe <jens.axboe@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Linus@smtp.osdl.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 28 Mar 2007 20:04:57 +0200 Michael S. Tsirkin wrote:

> > Subject    : first disk access after resume takes several minutes
> >              ('date' does not advance after resume from RAM, CONFIG_NO_=
HZ=3Dn)
> > References : http://lkml.org/lkml/2007/3/8/117
> >              http://lkml.org/lkml/2007/3/25/20
> > Submitter  : Michael S. Tsirkin <mst@mellanox.co.il>
> =

> ...
> =

> > Subject    : after resume: X hangs after drawing a couple of windows
> > References : http://lkml.org/lkml/2007/3/8/117
> > Submitter  : Michael S. Tsirkin <mst@mellanox.co.il>
> > Status     : unknown
> =

> ...
> =

> > > > > From: Jeff Chua <jeff.chua.linux@gmail.com>
> > > > > > It's related. I tested without CONFIG_HPET_TIMER, and now my X6=
0 can
> > > > > > suspend and resume from RAM (s2ram). Even better, it works
> > > > > > with/without CONFIG_NO_HZ.
> > =

> > Quoting Maxim <maximlevitsky@gmail.com>:
> > =

> > Hi,
> > 	I almost sure Iknow why this happens,
> > 			The problem is that both hpet clock source
> > 	and hpet clockevents doesn't have a suspend/resume function
> > 	On resume we should enable the main counter _and_ enable
> > 	legacy replacement mode, On my system main counter in
> > 	enabled, by I think by bios, but legacy replacement mode is
> > 	not, so if a system doesn't use lapic as a tick source, but
> > 	use hpet+broadcast, it will hang for sure on resume, and i
> > 	tested it
> > 	=

> > 			The patch below is a temporally fix, until
> > 	clock-events and clocksources will get proper suspend/resume
> > 	hooks:
> > =

> > 		Regards,
> > 			Maxim Levitsky
> =

> Bingo!
> =

> The patch below fixes the two problems (listed above) with
> resume from RAM that I have observed on my T60 with
> 2.6.21-rc5: with this patch applied, and with CONFIG_NO_HZ
> unset, date advances correctly, X functions properly and
> there is no delay on first disk access.
> =

> Thanks very much.
> =

> ---
> > Add suspend/resume for HPET
> > Signed-off-by: Maxim Levitsky <maximlevisky@gmail.com>
> =

> Maxim, do you plan to send this upstream?

with whitespace fixes, please...


> Acked-by: Michael S. Tsirkin <mst@dev.mellanox.co.il>
> =

> ---
> =

> diff --git a/arch/i386/kernel/hpet.c b/arch/i386/kernel/hpet.c
> index 0fd9fba..a1ec79e 100644
> --- a/arch/i386/kernel/hpet.c
> +++ b/arch/i386/kernel/hpet.c
> @@ -152,6 +152,16 @@ static void hpet_set_mode(enum clock_event_mode mode,
>  	unsigned long cfg, cmp, now;
>  	uint64_t delta;
>  =

> +
> +	if ( mode !=3D CLOCK_EVT_MODE_UNUSED && mode !=3D CLOCK_EVT_MODE_SHUTDO=
WN)
> +	{

	if (mode !=3D CLOCK_EVT_MODE_UNUSED && mode !=3D CLOCK_EVT_MODE_SHUTDOWN) {

> +		unsigned long cfg =3D hpet_readl(HPET_CFG);
> +		cfg |=3D HPET_CFG_ENABLE | HPET_CFG_LEGACY;
> +		hpet_writel(cfg, HPET_CFG);
> +		=


delete above line.

> +	}
> +		=

> +
>  	switch(mode) {
>  	case CLOCK_EVT_MODE_PERIODIC:
>  		delta =3D ((uint64_t)(NSEC_PER_SEC/HZ)) * hpet_clockevent.mult;


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
