From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH v2 07/13] power: bq24257: Extend scope of mutex protection
Date: Thu, 10 Sep 2015 12:05:49 -0500
Message-ID: <20150910170547.GB16768@borg>
References: <1441757557-7266-1-git-send-email-dannenberg@ti.com>
 <1441757557-7266-8-git-send-email-dannenberg@ti.com>
 <20150910134309.GI21512@lpalcu-desk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59521 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750970AbbIJRGU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 10 Sep 2015 13:06:20 -0400
Content-Disposition: inline
In-Reply-To: <20150910134309.GI21512@lpalcu-desk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurentiu Palcu <laurentiu.palcu@intel.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Thu, Sep 10, 2015 at 04:43:10PM +0300, Laurentiu Palcu wrote:
> On Tue, Sep 08, 2015 at 07:12:31PM -0500, Andreas Dannenberg wrote:
> > This commit extends the use of the existing mutex to pave the way for
> > using direct device access inside sysfs getter/setter routines in a
> > way that the access during interrupts and timer routines does not
> > interfere with device access by the CPU or between multiple cores.
> > 
> > This also addresses a potential race condition that could be caused
> > by bq24257_irq_handler_thread() and bq24257_iilimit_autoset() accessing
> > the device simultaneously.
> What potential race? AFAIK, we're doing all the operations through
> regmap, and regmap operations are serialized. It has its own mutex for
> this. Unless I got it all wrong...
> 
> So, IMHO, you don't need to protect against simultaneous device access.
> It's taken care of by regmap. Chip state data protection should be enough.

You are right, closely inspecting regmap.c shows that this driver indeed
uses mutexes (and instantiates them during init if needed) which is a
fantastic feature. The reasons for my proposed mutex changes were based
on the assumption that there is no built-in protection. Since this
assumption is wrong the potential race condition I pointed out in the
original code doesn't exist and I also don't see a need despite the
additions I make in this patch series to add/change the existing mutex
scheme. Will drop that patch.

Thanks,

--
Andreas Dannenberg
Texas Instruments Inc

> 
> laurentiu
> 
> 
