From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/4] cpufreq: fixes for v3.12
Date: Tue, 10 Sep 2013 22:07:04 +0200
Message-ID: <2170660.Fok0qj9HIB@vostro.rjw.lan>
References: <1378835989-19281-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:42184 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751169Ab3IJT4D (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 10 Sep 2013 15:56:03 -0400
In-Reply-To: <1378835989-19281-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-arm-kernel@lists.infradead.org, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

On Tuesday, September 10, 2013 06:59:45 PM Sudeep KarkadaNagesha wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> Hi Shawn, Guennadi,

Hi,

Thanks for the fixes, ->

> These are the fixes for the issue reported by Guennadi.
> cpu_dev should point to cpu0 device instead of cpufreq-cpu0 platform
> devices. The dev_id is also updated while registering the cpu clocks.
> 
> Can you review these ? Tested-by is much appreciated as I don't
> have hardware to check the fix.

-> but I'll wait for ACKs and Tested-by replies before taking them.

Thanks,
Rafael

