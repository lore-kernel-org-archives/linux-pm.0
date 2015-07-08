From: Julian Andres Klode <jak@jak-linux.org>
Subject: Re: sysfs charge thresholds for ThinkPads (and possibly others),
 preparation for second try
Date: Wed, 8 Jul 2015 11:40:00 +0200
Message-ID: <20150708113624.GA25015@debian.org>
References: <20150707210728.GA7524@jak-x230>
 <20150707235110.GA19748@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150707235110.GA19748@earth>
Sender: linux-acpi-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, evgeni@debian.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 08, 2015 at 01:51:10AM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Jul 07, 2015 at 11:07:28PM +0200, Julian Andres Klode wrote:
> > Hi everyone (Thinkpad-ACPI, ACPI, and Power supply maintainers),
> > 
> > some might know that I presented a patch set adding support for
> > charge thresholds to thinkpad_acpi about 1.5 years ago. 
> 
> Can you provide a link to the patch set?

Sure:
http://thread.gmane.org/gmane.linux.acpi.ibm-acpi.devel/3175

(it was not on the ACPI and Power MLs back then)

> 
> > Back then, one of the major rejections was that the functionality
> > for setting charge thresholds should be integrated into the
> > power supply stack somehow. I did not know who to contact back
> > then, but know I re-read MAINTAINERS and found all your addresses,
> > so I give it a second try.
> > 
> > One issue with just integrating it in the current battery
> > directories would be that ThinkPads are able to set charge
> > thresholds for batteries that are currently not inserted.
> 
> So the power supply device should be kept with
> POWER_SUPPLY_PROP_PRESENT being disabled (and most properties
> returning -ENODATA). The ACPI SBS driver seems to implement
> POWER_SUPPLY_PROP_PRESENT, but I didn't test it.

Yes, indeed.

> 
> > Back then I wrote:
> > > The next step is to integrate this properly with power supply
> > > and/or acpi battery. One way would be to add additional power
> > > supply properties and then add get/set_property() pointers to
> > > the acpi battery which it can fall back to if it does not support
> > > a requested property (and we would locate the ACPI battery and
> > > set those pointers to new thinkpad_acpi functions).
> > 
> > If you, the ACPI and power supply people, have any preferred
> > way (or any idea at all how) to proceed, that would be useful,
> > so I don't start working on it again, and then somebody does
> > not like it.
> 
> Adding charging thresholds as power_supply_property sounds
> fine to me.
> 

Right, it gets a bit more complicated though: Since the code is
platform-specific, it should live in the platform driver, so a
way is needed to extend the existing device with new properties
from the platform driver.

-- 
Julian Andres Klode  - Debian Developer, Ubuntu Member

See http://wiki.debian.org/JulianAndresKlode and http://jak-linux.org/.

Be friendly, do not top-post, and follow RFC 1855 "Netiquette".
    - If you don't I might ignore you.
