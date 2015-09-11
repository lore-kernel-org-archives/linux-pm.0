From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH v2 00/13] power: bq24257: Add support for bq24250/bq24251
Date: Fri, 11 Sep 2015 10:06:45 -0500
Message-ID: <20150911150645.GA18055@beast>
References: <1441757557-7266-1-git-send-email-dannenberg@ti.com>
 <20150910122616.GB21512@lpalcu-desk>
 <20150910212626.GA16256@borg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49128 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752626AbbIKPHU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 11 Sep 2015 11:07:20 -0400
Content-Disposition: inline
In-Reply-To: <20150910212626.GA16256@borg>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurentiu Palcu <laurentiu.palcu@intel.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Thu, Sep 10, 2015 at 04:26:26PM -0500, Andreas Dannenberg wrote:
> On Thu, Sep 10, 2015 at 03:26:16PM +0300, Laurentiu Palcu wrote:
> > On Tue, Sep 08, 2015 at 07:12:24PM -0500, Andreas Dannenberg wrote:
> > > v2:
[...]
> > > - Renamed/refactored filenames/symbols from bq24257 to bq2425x to
> > >   better reflect that multiple devices are covered. Despite initial
> > >   hesitation I feel this is a good opportunity for some clean-up as
> > >   the driver is still very new in the Kernel so the change should be
> > >   low risk. This also addresses one of Andrew Davis' feedback items.
> > >   Plus, it makes for a nice alignment with the existing bq2415x_charger
> > >   driver.
> > I can't say I fully agree with this rename but, on the other hand, since you
> > work for the chip manufacturer, you probably know better what other chips
> > (if any), with the same naming scheme, are due to be released and make
> > sure they are registry compatible. Otherwise, it'll be fun.
> 
> Yes the expectation is that potential future devices will fit with minor
> changes to the driver. I was given no indication that this wouldn't be
> the case but I'm double-checking with the product/planning people for
> that family.

Hi Laurentiu, full stop on the renaming. After double-checking with the
responsible bq242xx engineers it turns out it will be difficult to
maintain a family concept for the bq2425x driver moving forward (unless
you like nested switch/case statements sprinkled throughout the driver).

I feel sometimes even the most well-thought out and "future-proof"
family naming schemes will eventually turn into nothing more than a set
of GUIDs :) From a silicon vendor perspective there are several reasons
for that including that the namespace for part numbers (including their
length) is actually quite limited - a fact that's not immediately
obvious from the outside.

This being said I'll drop the renaming patch, and let's rely on folks
using Kconfig to find and use the correct driver.

--
Andreas Dannenberg
Texas Instruments Inc

