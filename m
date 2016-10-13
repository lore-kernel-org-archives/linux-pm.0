From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v7 2/8] power: add power sequence library
Date: Thu, 13 Oct 2016 09:04:42 +0200
Message-ID: <10186696.bBGEe05eC7@phil>
References: <1474342607-27512-1-git-send-email-peter.chen@nxp.com> <4691591.qnCGxrEkrZ@phil> <20161013012216.GA8114@b29397-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161013012216.GA8114@b29397-desktop>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw3-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org, troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, oscar-Bdbr4918Nnnk1uMJSBkQmQ@public.gmane.org, stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Am Donnerstag, 13. Oktober 2016, 09:22:16 CEST schrieb Peter Chen:
> On Wed, Oct 12, 2016 at 12:30:29PM +0200, Heiko Stuebner wrote:
> > Hi,
> > 
> > Am Dienstag, 20. September 2016, 11:36:41 CEST schrieb Peter Chen:
> > > We have an well-known problem that the device needs to do some power
> > > sequence before it can be recognized by related host, the typical
> > > example like hard-wired mmc devices and usb devices.
> > > 
> > > This power sequence is hard to be described at device tree and handled
> > > by
> > > related host driver, so we have created a common power sequence
> > > library to cover this requirement. The core code has supplied
> > > some common helpers for host driver, and individual power sequence
> > > libraries handle kinds of power sequence for devices.
> > > 
> > > pwrseq_generic is intended for general purpose of power sequence, which
> > > handles gpios and clocks currently, and can cover regulator and pinctrl
> > > in future. The host driver just needs to call of_pwrseq_on/of_pwrseq_off
> > > if only one power sequence is needed, else call of_pwrseq_on_list
> > > /of_pwrseq_off_list instead (eg, USB hub driver).
> > > 
> > > Signed-off-by: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
> > > Tested-by Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > Reviewed-by: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > > Tested-by: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > 
> > first of all, glad to see this move forward. I've only some qualms with
> > the
> > static number of allocated power sequences below.
> 
> Thanks for commenting it, the preallocate way is not a good way, but I
> can't find suitable way. See below comments.
> 
> > > +static int __init pwrseq_generic_register(void)
> > > +{
> > > +	struct pwrseq_generic *pwrseq_gen;
> > > +	int i;
> > > +
> > > +	for (i = 0; i < CONFIG_PWRSEQ_GENERIC_INSTANCE_NUMBER; i++) {
> > > +		pwrseq_gen = kzalloc(sizeof(*pwrseq_gen), GFP_KERNEL);
> > > +		if (!pwrseq_gen)
> > > +			return -ENOMEM;
> > > +
> > > +		pwrseq_gen->pwrseq.pwrseq_of_match_table = generic_id_table;
> > > +		pwrseq_gen->pwrseq.get = pwrseq_generic_get;
> > > +		pwrseq_gen->pwrseq.on = pwrseq_generic_on;
> > > +		pwrseq_gen->pwrseq.off = pwrseq_generic_off;
> > > +		pwrseq_gen->pwrseq.put = pwrseq_generic_put;
> > > +		pwrseq_gen->pwrseq.free = pwrseq_generic_free;
> > > +
> > > +		pwrseq_register(&pwrseq_gen->pwrseq);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +postcore_initcall(pwrseq_generic_register)
> > 
> > I see that you need to have it preallocated for the compatible matching,
> > but wouldn't it also work to either just register the type and allocate
> > dynamically or otherwise just allocate a new spare everytime
> > pwrseq_generic_get() picks up the previous spare?
> 
> Before compatible matching, the host driver doesn't know which pwrseq type
> for its child node, then doesn't know which pwrseq instance needs to be
> allocated. From dts, we don't know which pwrseq type for the node.

yes, that is why I was suggesting allocating one (or two) here in 
pwrseq_generic_register() and every time pwrseq_generic_get() grabs the last 
free sequence instance, you allocate a new free spare one in that function.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
