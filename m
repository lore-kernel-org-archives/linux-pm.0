From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH V2 3/3] cpufreq: exynos: Use generic platdev driver
Date: Wed, 30 Mar 2016 08:46:36 +0900
Message-ID: <56FB13DC.2090902@samsung.com>
References: <cover.1459233524.git.viresh.kumar@linaro.org>
 <81a8da75a0e7783e2b47f9e04297f167e8134afe.1459233524.git.viresh.kumar@linaro.org>
 <3810049.oQlCXiQ5bk@wuerfel>
 <CAKohpomQ9=YK79o0fqHqZ7xexHv5EMJSPx+4KrT0RxeMh+hwWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:18442 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbcC2Xqq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 19:46:46 -0400
In-reply-to: <CAKohpomQ9=YK79o0fqHqZ7xexHv5EMJSPx+4KrT0RxeMh+hwWg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rafael Wysocki <rjw@rjwysocki.net>, Arnd Bergmann <arnd.bergmann@linaro.org>, Kukjin Kim <kgene@kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>, Feng Xiao <xf@rock-chips.com>, Matthew McClintock <mmcclint@codeaurora.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>

On 30.03.2016 00:22, Viresh Kumar wrote:
> On 29 March 2016 at 20:34, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Tuesday 29 March 2016 12:09:49 Viresh Kumar wrote:
>>> -static void __init exynos_cpufreq_init(void)
>>> -{
>>> -       struct device_node *root = of_find_node_by_path("/");
>>> -       const struct of_device_id *match;
>>> -
>>> -       match = of_match_node(exynos_cpufreq_matches, root);
>>> -       if (!match) {
>>> -               platform_device_register_simple("exynos-cpufreq", -1, NULL, 0);
>>> -               return;
>>> -       }
>>> -
>>> -       platform_device_register_simple(match->data, -1, NULL, 0);
>>> -}
>>
>> How is the "exynos-cpufreq" case handled now? Is that no longer used now?
>> I assume the patch is correct based on Krzysztof's review, but it might be
>> good to explain this better.
> 
> That's stale code, the driver got removed some time back.

Yeah, that's old driver, no longer existing. It makes sense to split the
patch - first remove the stale exynos-cpufreq and then move cpufreq-dt.
This would help avoid confusion when grepping through the history.

Best regards,
Krzysztof

