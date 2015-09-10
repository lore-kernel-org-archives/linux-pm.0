From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH v2 00/13] power: bq24257: Add support for bq24250/bq24251
Date: Thu, 10 Sep 2015 16:26:26 -0500
Message-ID: <20150910212626.GA16256@borg>
References: <1441757557-7266-1-git-send-email-dannenberg@ti.com>
 <20150910122616.GB21512@lpalcu-desk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45600 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750943AbbIJV04 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 10 Sep 2015 17:26:56 -0400
Content-Disposition: inline
In-Reply-To: <20150910122616.GB21512@lpalcu-desk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurentiu Palcu <laurentiu.palcu@intel.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Thu, Sep 10, 2015 at 03:26:16PM +0300, Laurentiu Palcu wrote:
> On Tue, Sep 08, 2015 at 07:12:24PM -0500, Andreas Dannenberg wrote:
> > This patch series extends the driver to also support bq24250/bq24251.
> > 
> > The bq24250/251/257 devices have a very similar feature set and are
> > virtually identical from a control register point of view so it made
> > sense to extend the existing driver rather than submitting a new driver.
> > In addition to the new device support the driver is also extended to
> > allow access to some device features previously hidden. Basic and
> > potentially dangerous charger config parameters affecting the actual
> > charging of the Li-Ion battery are only configurable through firmware
> > rather than sysfs properties. However some newly introduced properties
> > are exposed through sysfs properties as access to them may be desired
> > from userspace. For example, it is now possible to manually configure
> > the maximum current drawn from the input source to accommodate different
> > chargers (0.5A, 1.5A, 2.0A and so on) based on system knowledge a
> > userspace application may have rather than rely on the auto-detection
> > mechanism that may not work in all possible scenarios.
> > 
> > Note that most patches have dependencies on other patches in the series.
> > 
> > v2:
> > - Aligned DT bindings better with existing "ti,*" charger bindings
> > - Dropped patch that improperly reported a missing battery as a dead
> >   battery
> > - Fixed (hopefully, that is -- still waiting for my test platform)
> >   issue with how the private ACPI driver_data used to identify which
> >   bq2425x device to use
> > - Removed boolean DT/ACPI properties mostly by replacing them with more
> >   intelligent handling in the driver
> > - Rework/clarification of DT bindings doc
> > - Renamed/refactored filenames/symbols from bq24257 to bq2425x to
> >   better reflect that multiple devices are covered. Despite initial
> >   hesitation I feel this is a good opportunity for some clean-up as
> >   the driver is still very new in the Kernel so the change should be
> >   low risk. This also addresses one of Andrew Davis' feedback items.
> >   Plus, it makes for a nice alignment with the existing bq2415x_charger
> >   driver.
> I can't say I fully agree with this rename but, on the other hand, since you
> work for the chip manufacturer, you probably know better what other chips
> (if any), with the same naming scheme, are due to be released and make
> sure they are registry compatible. Otherwise, it'll be fun.

Yes the expectation is that potential future devices will fit with minor
changes to the driver. I was given no indication that this wouldn't be
the case but I'm double-checking with the product/planning people for
that family.

> For the entire patchset, please run it through 'checkpatch --strict'.
> There are some minor style issues that are worth fixing.

Ok will do. But I'm not a big fan of --strict, especially the alignment
of function arguments that spill into the next line. If it is required
by the Kernel community (is it?) why not making --strict a default-on
option of checkpatch.pl or mandating it in one of the docs?
 
> Regarding the DT patch (on which I'll comment separately, after I go
> through the entire patchset), make sure you put it before the code
> implementing the binding [1].
> 
> [1] Documentation/devicetree/bindings/submitting-patches.txt

I had actually read this but my DT doc binding patch also renames the
binding file itself. So technically it isn't valid until after the
rename patch was applied... which is against the patch ordering... Any
creative idea on how to solve this?

Thanks,

--
Andreas Dannenberg
Texas Instruments Inc

