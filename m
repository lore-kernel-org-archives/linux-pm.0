From: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 01/11] dt: power: bq24257-charger: Cover additional
 devices
Date: Wed, 23 Sep 2015 11:14:56 +0300
Message-ID: <20150923081456.GC15509@lpalcu-desk>
References: <1442612399-341-1-git-send-email-dannenberg@ti.com>
 <1442612399-341-2-git-send-email-dannenberg@ti.com>
 <20150922162448.GE4235@earth>
 <20150922215823.GA30297@beast>
 <20150923003414.GB4359@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150923003414.GB4359@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ramakrishna Pallala <ramakrishna.pallala-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Wed, Sep 23, 2015 at 02:34:15AM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Sep 22, 2015 at 04:58:24PM -0500, Andreas Dannenberg wrote:
> > On Tue, Sep 22, 2015 at 06:24:48PM +0200, Sebastian Reichel wrote:
> > > On Fri, Sep 18, 2015 at 04:39:49PM -0500, Andreas Dannenberg wrote:
> > > > Extend the bq24257 charger's device tree documentation to cover the
> > > > bq24250 and bq24251 devices as well feature additions.
> > > 
> > > The binding looks fine to except for:
> > > 
> > > > +- stat-gpios: GPIO used for the devices STAT_IN pin. Alternatively the pin can
> > > > +    also be defined through the standard interrupt definition properties (see
> > > > +    optional properties section below). Only use one method.
> > > 
> > > Why do you expose two ways for this?
> > 
> > Hi Sebastian. The original driver exposed this - it just didn't
> > document it in the DT binding doc. I'm not sure why this was introduced
> > in the first place (Laurentiu?). I know we can't change the API but
> > since it was never documented maybe we can remove it?
> 
> It seems this is neither documented, nor used. So I guess it can be
> removed. Let's wait for feedback from Laurentiu, though.
This was needed to have both ACPI and DT enumeration work. At the time I
wrote the driver, GpioInt resources in ACPI were not passed to the
driver in client->irq, as opposed to DT enumeration.

However, conveniently enough, the patch below landed in master by the
same time bq24257 driver went in. So, I believe it should be safe now to
remove the stat-gpio probing.

commit 845c877009cf014b971aab7f54613f9185a824b0
Author: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date:   Wed May 6 13:29:08 2015 +0300

    i2c / ACPI: Assign IRQ for devices that have GpioInt automatically

laurentiu
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
