From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 6/8] cpufreq-dt: free OPP table created during ->init()
Date: Tue, 25 Nov 2014 21:15:45 +0100 (CET)
Message-ID: <2021992776.218020.1416946545852.JavaMail.open-xchange@oxbaltgw08.schlund.de>
References: <cover.1416910766.git.viresh.kumar@linaro.org> <1ac3e8c67c7bd2a962aed6561693d16ca5cd9db9.1416910766.git.viresh.kumar@linaro.org>
Reply-To: Stefan Wahren <stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:53520 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbaKYUP5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Nov 2014 15:15:57 -0500
In-Reply-To: <1ac3e8c67c7bd2a962aed6561693d16ca5cd9db9.1416910766.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: nm@ti.com, linux-pm@vger.kernel.org, sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org

Hi Viresh,

> Viresh Kumar <viresh.kumar@linaro.org> hat am 25. November 2014 um 11:34
> geschrieben:
>
>
> OPP layer now supports freeing of OPPs and we should free them once they
> aren't
> useful anymore.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

i applied the complete patch series to my repository and tested successfully the
cpufreq-dt with my i.MX28 board.

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

Thanks

Stefan
