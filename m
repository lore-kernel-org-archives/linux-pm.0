From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V2 0/7] cpufreq: Get rid of cpufreq-dt's platform data
Date: Wed, 27 Apr 2016 11:33:20 +0200
Message-ID: <4610101.72SJXreBbn@wuerfel>
References: <cover.1461727086.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:53992 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453AbcD0Jdk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2016 05:33:40 -0400
In-Reply-To: <cover.1461727086.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linaro-kernel@lists.linaro.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, linux-pm@vger.kernel.org, sboyd@codeaurora.org, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On Wednesday 27 April 2016 08:52:20 Viresh Kumar wrote:
> Hi Guys,
> 
> The aim of the series is to kill the users of cpufreq-dt's platform
> data, i.e. mvebu. And because that required a new API to the OPP core,
> this just became a mix of cpufreq and OPP patches.
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
