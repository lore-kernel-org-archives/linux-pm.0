From: Paul Walmsley <paul@pwsan.com>
Subject: Re: omap cpufreq driver in multi-platform kernels
Date: Wed, 27 Mar 2013 17:48:17 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1303271747210.17356@utopia.booyaka.com>
References: <5152503C.2050503@gmail.com> <alpine.DEB.2.00.1303270212110.8161@utopia.booyaka.com> <20130327133220.GA30868@kahuna>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47887 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754542Ab3C0RsS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Mar 2013 13:48:18 -0400
In-Reply-To: <20130327133220.GA30868@kahuna>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Rob Herring <robherring2@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Shawn Guo <shawn.guo@linaro.org>, linux-pm@vger.kernel.org, Mark Langsdorf <mark.langsdorf@calxeda.com>

Hi

On Wed, 27 Mar 2013, Nishanth Menon wrote:

> We should deprecate usage on omap-cpufreq driver eventually, instead go
> towards embracing the SoC generic implementation of cpufreq-cpu0 driver
> IMHO.
> http://marc.info/?l=linux-omap&m=136371580826031&w=2
> is the series to support cpufreq_cpu0 driver in DT based boot.
> Would you think this approach is sane? 

Haven't looked closely at the series, but the idea makes sense to me, as 
long as OMAP doesn't need to do anything too exotic in the CPUFreq driver.



- Paul
