From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 1/3] thermal: exynos: List vtmu-supply as optional
 property in DT binding
Date: Tue, 8 Mar 2016 13:51:55 -0800
Message-ID: <20160308215153.GA10983@localhost.localdomain>
References: <1455819551-4666-1-git-send-email-javier@osg.samsung.com>
 <1455819551-4666-2-git-send-email-javier@osg.samsung.com>
 <20160308210744.GA8145@localhost.localdomain>
 <56DF4469.7090603@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33268 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbcCHVv7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2016 16:51:59 -0500
Content-Disposition: inline
In-Reply-To: <56DF4469.7090603@osg.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-samsung-soc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Pawel Moll <pawel.moll@arm.com>, Zhang Rui <rui.zhang@intel.com>, Mark Rutland <mark.rutland@arm.com>

On Tue, Mar 08, 2016 at 06:30:17PM -0300, Javier Martinez Canillas wrote:
> Hello Eduardo,
> 
> On 03/08/2016 06:07 PM, Eduardo Valentin wrote:
> > On Thu, Feb 18, 2016 at 03:19:09PM -0300, Javier Martinez Canillas wrote:
> >> The Exynos Thermal Management Unit binding says that the vtmu-supply
> >> is optional but is listed in the required properties section. Add an
> >> optional properties section and move the regulator property there.
> >>
> >> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> >> ---
> >>
> >>  Documentation/devicetree/bindings/thermal/exynos-thermal.txt | 9 ++++++---
> >>  1 file changed, 6 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
> >> index faa62059b5c5..70b4c16c7ed8 100644
> >> --- a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
> >> +++ b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
> >> @@ -41,9 +41,6 @@
> >>  		for current TMU channel
> >>  	-- "tmu_sclk" clock for functional operation of the current TMU
> >>  		channel
> >> -- vtmu-supply: This entry is optional and provides the regulator node supplying
> >> -		voltage to TMU. If needed this entry can be placed inside
> >> -		board/platform specific dts file.
> >>  
> >>  The Exynos TMU supports generating interrupts when reaching given
> >>  temperature thresholds. Number of supported thermal trip points depends
> > 
> > Where is this patch based on? I checked it on my fixes and linus
> > branches, also on linux-next 0308 branch, and none of those apply clean.
> >
> 
> I mentioned in the cover letter [0] that this series were based on top
> of in-flight patches from Krzysztof Kozlowski to avoid merge conflicts.
> 
> Those have not landed yet either so maybe you could look at those first?
>  
> > Can you please send this based on upstream kernel?
> >
> 
> Ok, my intention was to make picking both patch series easier but if
> this is inconvenient to you, I can base on top of current mainline
> and let you handle the merge conflicts (or ask Krzysztof to resend
> on top of my patches).
> 
> [0]: https://lkml.org/lkml/2016/2/18/591

Got it. I am checking his patches first then.

>  
> Best regards,
> -- 
> Javier Martinez Canillas
> Open Source Group
> Samsung Research America
