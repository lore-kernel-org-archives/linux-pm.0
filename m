From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH 13/13] dt: power: bq24257-charger: Cover additional
 devices
Date: Thu, 3 Sep 2015 11:09:26 -0500
Message-ID: <20150903160926.GA26659@borg>
References: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
 <1441073435-12349-14-git-send-email-dannenberg@ti.com>
 <CAJKOXPeyMeUUon0E9Fhm18SHJEaQPEbGAWwU+MKwgt-30AXHiA@mail.gmail.com>
 <20150902140332.GA24076@borg>
 <55E7A2E8.2060306@samsung.com>
 <20150903014741.GA25605@borg>
 <55E7A8F8.7050300@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33919 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755846AbbICQJ7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 3 Sep 2015 12:09:59 -0400
Content-Disposition: inline
In-Reply-To: <55E7A8F8.7050300@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Thu, Sep 03, 2015 at 10:57:12AM +0900, Krzysztof Kozlowski wrote:
> On 03.09.2015 10:47, Andreas Dannenberg wrote:
> > On Thu, Sep 03, 2015 at 10:31:20AM +0900, Krzysztof Kozlowski wrote:
> >> I still don't get why you need extra "ti,pg-gpio-disable" property. It
> >> could work like this:
> >> 1. Get rid of "ti,pg-gpio-disable" and make "pg-gpio" optional.
> >> 2. If it is present, use it.
> >> 3. If it is not present, use software based approach (the same as
> >> setting "ti,pg-gpio-disable" previously).
> >>
> >> Would that work?
> > 
> > Similar to the earlier comment - the idea was to have it more explicit.
> > Plus, the original driver would hard-fail when the "pg-gpio" pin is not
> > provided (since it was essential for that driver's ability to function).
> > If I change to automatically fallback to the SW solution such an error
> > case would in theory not be 100% backward compatible. I could however
> > more clearly indicate/log which method is being used (dev_info) so
> > somebody rummaging through the logs would still see it. Will simplify.
> 
> Right, the kernel's backward compatibility has to be preserved. However
> for bindings I am not sure.

Hi Krzysztof. Please see pages 3-5 in the below PDF, that's what I had
in mind. Maybe I mis-interpreted it or there is newer information.
http://events.linuxfoundation.org/sites/events/files/slides/petazzoni-dt-as-stable-abi-fairy-tale.pdf

With the proposed changes, while the existing bindings (strings) would
stay the same, the failure behavior in one specific use case would be
slightly different. The question is, where should we draw the line for
compatibility? I would argue in this case the general usage is not
affected so it should be OK making the change/simplification you propose
(getting rid of "ti,pg-gpio-disable"). 
 
> Let's assume booting on device with bq24257.
> 1. Old kernel booted with a DTB which doesn't have "pg-gpio" would print
> error (probe would fail).
> 2. New kernel booted in the same situation (1) would assume GPIOs have
> to be disabled.
> 
> 3. Old kernel booted with your previous solution (DTB containing both
> "pg-gpio" and "ti,pg-gpio-disable") would work fine ignoring the
> "disable" property.
> 4. New kernel in the same situation (3) would disable GPIOs.
> 
> There is a difference between (1) and (3). New DTB is not backward
> compatible with old kernels for existing bq24257 devices.
> 
> Am I understanding this correctly?

Well almost. I think the difference between case 1 and 3 isn't really an
issue from a use case point of view. The case I was trying to describe
is as follows (let's call it case 5):

5. An old DTB not containing "pg-gpio" (or with that property being
misconfigured) is booted with the new Kernel. The boot will succeed as
the SW approach for PG detection gets invoked automatically.

The difference now is between (1) and (5). If in (5) somebody specifies
"pg-gpio" they would want to explicitly use this pin and be notified if
the respective setup fails. My proposal earlier for this was to output
through dev_info() during driver probe whether an actual GPIO pin is
being used for power-good detection or whether the fall-back SW
algorithm has been invoked. This way, at least there is a notification.



Thanks and Regards,

--
Andreas Dannenberg
Texas Instruments Inc

> 
> Best regards,
> Krzysztof
