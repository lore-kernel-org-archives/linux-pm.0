From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [GIT PULL] : ARM cpuidle changes for 4.1
Date: Wed, 25 Mar 2015 12:47:50 +0100
Message-ID: <3700462.Yl2LKsK0sW@vostro.rjw.lan>
References: <55127A53.8050206@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64553 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751876AbbCYLXq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2015 07:23:46 -0400
In-Reply-To: <55127A53.8050206@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>

On Wednesday, March 25, 2015 10:05:23 AM Daniel Lezcano wrote:
> 
> Hi Rafael,
> 
> this PR request has the following content:
> 
>   - Removed the duplicate header inclusion (Daniel Lezcano).
> 
>   - Unified the generic cpuidle ARM driver with ARM64. Each platform can 
> now define their 'enable-method' in the DT thus allowing to split the 
> low level PM code from the generic cpuidle framework (Daniel Lezcano).
> 
>   - Allowed the generic ARM cpuidle driver to register per device and 
> prevent to register the cpuidle device when the underlying hardware is 
> misconfigured or an error occurs, thus allowing to fail gracefully 
> (Daniel Lezcano).
> 
> Thanks !

Pulled, thanks!

Rafael

