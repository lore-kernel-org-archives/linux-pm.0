From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] thermal: use cpumask_var_t for on-stack cpu masks
Date: Fri, 3 Feb 2017 09:16:18 +0530
Message-ID: <20170203034618.GI7458@vireshk-i7>
References: <20170202144821.3721926-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34401 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752268AbdBCDqX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Feb 2017 22:46:23 -0500
Received: by mail-pg0-f41.google.com with SMTP id 14so2716004pgg.1
        for <linux-pm@vger.kernel.org>; Thu, 02 Feb 2017 19:46:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170202144821.3721926-1-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 02-02-17, 15:46, Arnd Bergmann wrote:
> Putting a bare cpumask structure on the stack produces a warning on
> large SMP configurations:
> 
> drivers/thermal/cpu_cooling.c: In function 'cpufreq_state2power':
> drivers/thermal/cpu_cooling.c:644:1: warning: the frame size of 1056 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> drivers/thermal/cpu_cooling.c: In function '__cpufreq_cooling_register':
> drivers/thermal/cpu_cooling.c:898:1: warning: the frame size of 1104 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> The recommended workaround is to use cpumask_var_t, which behaves just like
> a normal cpu mask in most cases, but turns into a dynamic allocation
> when CONFIG_CPUMASK_OFFSTACK is set.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/thermal/cpu_cooling.c | 39 ++++++++++++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 13 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
