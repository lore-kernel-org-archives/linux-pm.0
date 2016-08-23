From: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 2/8] power: add power sequence library
Date: Tue, 23 Aug 2016 09:25:25 +0800
Message-ID: <20160823012525.GA13986@shlinux2>
References: <1471252398-957-1-git-send-email-peter.chen@nxp.com>
 <1471252398-957-3-git-send-email-peter.chen@nxp.com>
 <20160822065158.GB4362@shlinux2>
 <20160822102331.bimz22w6z2v65jd7@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160822102331.bimz22w6z2v65jd7@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw3-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org, troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, oscar-Bdbr4918Nnnk1uMJSBkQmQ@public.gmane.org, stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 22, 2016 at 12:23:31PM +0200, Sebastian Reichel wrote:
> Hi Peter,
> 
> On Mon, Aug 22, 2016 at 02:51:58PM +0800, Peter Chen wrote:
> > On Mon, Aug 15, 2016 at 05:13:12PM +0800, Peter Chen wrote:
> > > We have an well-known problem that the device needs to do some power
> > > sequence before it can be recognized by related host, the typical
> > > example like hard-wired mmc devices and usb devices.
> > > 
> > > This power sequence is hard to be described at device tree and handled by
> > > related host driver, so we have created a common power sequence
> > > library to cover this requirement. The core code has supplied
> > > some common helpers for host driver, and individual power sequence
> > > libraries handle kinds of power sequence for devices.
> > > 
> > > pwrseq_generic is intended for general purpose of power sequence, which
> > > handles gpios and clocks currently, and can cover regulator and pinctrl
> > > in future. The host driver calls pwrseq_alloc_generic to create
> > > an generic pwrseq instance.
> > > 
> > > Signed-off-by: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
> > > Tested-by Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > Reviewed-by: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > > Tested-by: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > 
> > Hi Greg, Sebastian, Dmitry, and David
> > 
> > I find the code under drivers/power have several subsystems.
> > Does this power sequence patch set can go git://git.infradead.org/battery-2.6.git?
> > Or can go the Greg's tree?
> 
> I think this does not really fit into the power-supply tree.
> I would expect this to go through Rafael's linux-pm tree.

Ok, thanks. Rafael, would you agree with that? If you agree, I will
update MAINTAINER file.

> 
> Note: I moved all the power-supply code into drivers/power/supply/
> in linux-next, among other things because of this patchset. To avoid
> merge conflicts in drivers/power/Makefile and drivers/power/Kconfig
> the tree pulling this patchset should also pull a (yet to be
> created) immutable branch containing
> https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git/commit/drivers/power?h=for-next&id=8c0984e5a75337df513047ec92a6c09d78e3e5cd
> 

Yes, I found the rebase conflict with it, I will fix it at next
revision.

-- 

Best Regards,
Peter Chen
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
