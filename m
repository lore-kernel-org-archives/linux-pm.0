From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH] ARM: defconfigs: use CONFIG_CPUFREQ_DT
Date: Mon, 15 Dec 2014 10:50:37 -0800
Message-ID: <7h1to0iw76.fsf@deeprootsystems.com>
References: <63217079d4b61d835fed98198ae1e3f0e6329de1.1418617005.git.viresh.kumar@linaro.org>
	<2757282.fj6z18fAYb@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:41704 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbaLOSuk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Dec 2014 13:50:40 -0500
Received: by mail-pd0-f179.google.com with SMTP id fp1so12259601pdb.10
        for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2014 10:50:40 -0800 (PST)
In-Reply-To: <2757282.fj6z18fAYb@vostro.rjw.lan> (Rafael J. Wysocki's message
	of "Mon, 15 Dec 2014 16:00:12 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, arm@kernel.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, linux-arm-kernel@lists.infradead.org, olof@lixom.net, arnd.bergmann@linaro.org, stable@vger.kernel.org

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> On Monday, December 15, 2014 09:48:19 AM Viresh Kumar wrote:
>> CONFIG_GENERIC_CPUFREQ_CPU0 disappeared with commit bbcf071969b20f
>> ("cpufreq: cpu0: rename driver and internals to 'cpufreq_dt'") and some
>> defconfigs are still using it instead of the new one.
>> 
>> Use the renamed CONFIG_CPUFREQ_DT generic driver.
>> 
>> Cc: <stable@vger.kernel.org>        # 3.18
>> Reported-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> OK, so who should be applying this?
>

Normally, we take these defconfig changes through the arm-soc tree, and
I think that should continue, otherwise we'll be bound to have conflicts.

Note all the pull requests for this merge window are already sent, but
I'll queue this up in arm-soc/fixes so it can make it during the
v3.19-rc cycle.

Thanks,

Kevin

