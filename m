From: Nishanth Menon <nm@ti.com>
Subject: Re: omap cpufreq driver in multi-platform kernels
Date: Wed, 27 Mar 2013 13:02:49 -0500
Message-ID: <20130327180248.GB32693@kahuna>
References: <5152503C.2050503@gmail.com>
 <alpine.DEB.2.00.1303270212110.8161@utopia.booyaka.com>
 <20130327133220.GA30868@kahuna>
 <alpine.DEB.2.00.1303271747210.17356@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36930 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751128Ab3C0SCz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 27 Mar 2013 14:02:55 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1303271747210.17356@utopia.booyaka.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rob Herring <robherring2@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Shawn Guo <shawn.guo@linaro.org>, linux-pm@vger.kernel.org, Mark Langsdorf <mark.langsdorf@calxeda.com>

On 17:48-20130327, Paul Walmsley wrote:
> Hi
> 
> On Wed, 27 Mar 2013, Nishanth Menon wrote:
> 
> > We should deprecate usage on omap-cpufreq driver eventually, instead go
> > towards embracing the SoC generic implementation of cpufreq-cpu0 driver
> > IMHO.
> > http://marc.info/?l=linux-omap&m=136371580826031&w=2
> > is the series to support cpufreq_cpu0 driver in DT based boot.
> > Would you think this approach is sane? 
> 
> Haven't looked closely at the series, but the idea makes sense to me, as 
Thanks.
> long as OMAP doesn't need to do anything too exotic in the CPUFreq driver.
:) I wish that were the case, from an SoC entitlement point of view,
purely controlling frequency and regulator is not sufficent for
most OMAPs/AM variants. We do have to deal with ABB and AVS (now a
multitude of class variants to deal with) - part of the rationale for
switching to generic cpufreq as part of DT steps is to force ourselves to
adhere to common code and entitle required SoC feature set.

If you get a chance, it would be nice to hear your views on the intermediate
step(the patch series pointed above) as part of overall OMAP transition to DT.
-- 
Regards,
Nishanth Menon
