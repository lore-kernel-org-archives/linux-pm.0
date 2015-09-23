From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH v5 09/11] power: bq24257: Allow input current limit sysfs
 access
Date: Wed, 23 Sep 2015 13:32:58 -0500
Message-ID: <20150923183254.GA26441@beast>
References: <1442612399-341-1-git-send-email-dannenberg@ti.com>
 <1442612399-341-10-git-send-email-dannenberg@ti.com>
 <20150922191649.GA9949@earth>
 <20150922221044.GB30297@beast>
 <20150923002906.GA4359@earth>
 <20150923141146.GA6289@borg>
 <20150923150228.GA5254@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42239 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753324AbbIWSdc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 23 Sep 2015 14:33:32 -0400
Content-Disposition: inline
In-Reply-To: <20150923150228.GA5254@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Wed, Sep 23, 2015 at 05:02:28PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Sep 23, 2015 at 09:11:46AM -0500, Andreas Dannenberg wrote:
> > Ok. So how should we best go about extending the usage of the
> > 'input_current_limit' sysfs node for this charger? You mentioned
> > writing 'auto' into it should enable the auto-detection mode. I suppose
> > writing a fixed current value will disable it. But how to indicate to
> > the user when reading 'input_current_limit' whether auto mode is enabled
> > or not (I think this is something we should do).
> 
> Right, I haven't thought of this.
> 
> > Can we return a mixed number/string like this?
> > 
> > # Example: charger auto detection mode is disabled, and input current
> > # limit is configured as 500mA.
> > 
> > $ cat input_current_limit
> > 500000
> > 
> > # Example: charger auto detection mode is enabled, and a charger
> > # supporting 1A was detected (note the mixed number/string thats
> > # returned)
> > 
> > $ cat input_current_limit
> > 1000000 (auto)
> > 
> > Would that work?
> 
> No. sysfs nodes should only contain one value per file.
> 
> > Or should we introduce a new sysfs property?
> 
> So maybe keep this patch as is (disallow setting the limit in auto
> mode) and create another file for setting (and getting) the mode.

Thanks for the continued feedback. Will look into this and add a new
property.
 
> Also it might be a good idea to return to safe defaults when the
> charger is disconnected (-> reset to DT specified values).

It already does this when the charger type auto-detection is enabled.
When configured for manually setting the input current limit the use
case is a bit more complex and I do not recommend resetting the limit to
500mA. Let me explain why:

1) Using USB chargers is only one of the ways the bq2525x devices can be
used in a system. Imagine a shipping product that comes with its own
proprietary wall power (or built-in) supply that let's say cranks out
2A.  As a vendor you want to configure your system (meaning, the bq2425x
via DT) to a fixed value of 2A. The user un-plugging and re-plugging the
power supply should not arbitrarily change that pre-configured limit

2) Even in case of USB chargers, userspace could detect the power
un-plug event, and re-configure the limit to something else.  So I think
it's really policy that should not be implemented in the Kernel driver.

Regards,

--
Andreas Dannenberg
Texas Instruments Inc

