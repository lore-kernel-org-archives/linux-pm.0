From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] dt-bindings: thermal: Add binding document for
 Mediatek thermal controller
Date: Sat, 19 Dec 2015 18:12:16 -0800
Message-ID: <20151220021214.GA11054@localhost.localdomain>
References: <1448883753-19068-1-git-send-email-s.hauer@pengutronix.de>
 <1448883753-19068-2-git-send-email-s.hauer@pengutronix.de>
 <CAGS+omCPonvXBTjOqpKrJX0Ebw0KF6TDKH+zRas-3FaAhUWL2w@mail.gmail.com>
 <20151217192329.GA7999@localhost.localdomain>
 <20151218071633.GG11966@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151218071633.GG11966-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hello Sascha,

On Fri, Dec 18, 2015 at 08:16:33AM +0100, Sascha Hauer wrote:
> On Thu, Dec 17, 2015 at 11:23:31AM -0800, Eduardo Valentin wrote:
> > On Wed, Dec 16, 2015 at 07:23:22PM +0800, Daniel Kurtz wrote:
> > > On Mon, Nov 30, 2015 at 7:42 PM, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> > > > +Example:

<cut>

> > > > +
> > > > +       thermal: thermal@1100b000 {
> > > > +               #thermal-sensor-cells = <1>;
> > > 
> > > Tiny nit: this should now be:
> > > 
> > > #thermal-sensor-cells = <0>;
> > 
> > 
> > This is actually not so tiny'shy. Why does this driver masks out all
> > sensors available? Why don't we expose all of them and use id property
> > to expose and identify each of them?
> 
> This has been the case until v9 of this series. It was requested by
> Mediatek that the CPU frequency regulation works better when the maximum
> of all sensors is taken instead of only single sensors. We decided to
> expose the maximum of all sensors in the device tree. IN the end it will
> be easier to add additional sensors should we need them later than it is
> to get rid of sensors we don't need.

Apologize as I completely missed this transition from v9 to v10. In
fact, I really cannot understand the benefit of having such constraint
implemented in the driver. In device tree you can mark a thermal zone as
status disabled and it won't appear in your system.

One can select which sensors / thermal zones are required. And even
reuse same dtsi, and change status on dts per board. 

The combination of the above, with the possibility to select the maximum
from thermal core / sysfs, would be bring much more flexibility for a
system engineer, than having the maximum coded in the driver, because,
well, changing that relation would require changing the code. If you
keep the driver as simple as possible, changing the this setup later
would be as simple as changing the dts(i).

What do you think?

BR,

> 
> Sascha
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
