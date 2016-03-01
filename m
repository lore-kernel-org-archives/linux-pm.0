From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] cpufreq: qoriq: allow building as module with THERMAL=m
Date: Tue, 01 Mar 2016 03:00:22 +0100
Message-ID: <4312477.lDX3yCWWFs@vostro.rjw.lan>
References: <1456761867-1742824-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52644 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751117AbcCAB6m (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Feb 2016 20:58:42 -0500
In-Reply-To: <1456761867-1742824-1-git-send-email-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, February 29, 2016 05:04:20 PM Arnd Bergmann wrote:
> My previous patch to avoid link errors with the qoriq cpufreq
> driver disallowed all of the broken cases, but also prevented
> the driver from being built when CONFIG_THERMAL is a module.
> 
> This changes the dependency to allow the cpufreq driver to
> also be a module in this case, just not built-in.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: cpufreq: qoriq depends on thermal
> ---
> 
> If possible, please fold this change directly into the previous
> commit

Done.

I've applied the [2/2] too.

Thanks,
Rafael

