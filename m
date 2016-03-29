From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 3/3] cpufreq: exynos: Use generic platdev driver
Date: Tue, 29 Mar 2016 20:52:46 +0530
Message-ID: <CAKohpomQ9=YK79o0fqHqZ7xexHv5EMJSPx+4KrT0RxeMh+hwWg@mail.gmail.com>
References: <cover.1459233524.git.viresh.kumar@linaro.org>
	<81a8da75a0e7783e2b47f9e04297f167e8134afe.1459233524.git.viresh.kumar@linaro.org>
	<3810049.oQlCXiQ5bk@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:33481 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757328AbcC2PWr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 11:22:47 -0400
Received: by mail-vk0-f48.google.com with SMTP id k1so22580834vkb.0
        for <linux-pm@vger.kernel.org>; Tue, 29 Mar 2016 08:22:47 -0700 (PDT)
In-Reply-To: <3810049.oQlCXiQ5bk@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rafael Wysocki <rjw@rjwysocki.net>, Arnd Bergmann <arnd.bergmann@linaro.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Feng Xiao <xf@rock-chips.com>, Matthew McClintock <mmcclint@codeaurora.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>

On 29 March 2016 at 20:34, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 29 March 2016 12:09:49 Viresh Kumar wrote:
>> -static void __init exynos_cpufreq_init(void)
>> -{
>> -       struct device_node *root = of_find_node_by_path("/");
>> -       const struct of_device_id *match;
>> -
>> -       match = of_match_node(exynos_cpufreq_matches, root);
>> -       if (!match) {
>> -               platform_device_register_simple("exynos-cpufreq", -1, NULL, 0);
>> -               return;
>> -       }
>> -
>> -       platform_device_register_simple(match->data, -1, NULL, 0);
>> -}
>
> How is the "exynos-cpufreq" case handled now? Is that no longer used now?
> I assume the patch is correct based on Krzysztof's review, but it might be
> good to explain this better.

That's stale code, the driver got removed some time back.
