From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v4 0/6] cpufreq: use generic cpufreq drivers for Exynos4x12
 platform
Date: Fri, 07 Aug 2015 13:52:01 +0900
Message-ID: <55C43971.5010504@samsung.com>
References: <1438868514-8814-1-git-send-email-b.zolnierkie@samsung.com>
 <015301d0d0a3$1396c900$3ac45b00$@kernel.org> <20150807035018.GF6325@linux>
 <20150807035156.GG6325@linux> <55C43085.8090506@samsung.com>
 <20150807043037.GH6325@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:18185 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960AbbHGEwG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Aug 2015 00:52:06 -0400
In-reply-to: <20150807043037.GH6325@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kukjin Kim <kgene@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd.bergmann@linaro.org>, 'Bartlomiej Zolnierkiewicz' <b.zolnierkie@samsung.com>, 'Thomas Abraham' <thomas.ab@samsung.com>, 'Sylwester Nawrocki' <s.nawrocki@samsung.com>, 'Michael Turquette' <mturquette@baylibre.com>, 'Tomasz Figa' <tomasz.figa@gmail.com>, 'Lukasz Majewski' <l.majewski@samsung.com>, 'Heiko Stuebner' <heiko@sntech.de>, 'Chanwoo Choi' <cw00.choi@samsung.com>, 'Kevin Hilman' <khilman@linaro.org>, 'Javier Martinez Canillas' <javier@dowhile0.org>, 'Tobias Jakobi' <tjakobi@math.uni-bielefeld.de>, 'Anand Moon' <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 07.08.2015 13:30, Viresh Kumar wrote:
> On 07-08-15, 13:13, Krzysztof Kozlowski wrote:
>> Still patches 1/6 and 6/6 need your acks. Is the patch 1/6 a
>> prerequisite for others? It does not look like a prerequisite... but it
>> was put at the beginning of the patchset.
> 
> Patch 1/6 is required to get boost working, that's all.. Not sure how
> important is that. Anyway, that will work without 1/6 as well, all you
> need to do is enable CONFIG_CPU_FREQ_BOOST_SW in you .config.
> 
> Anyway, it should go via pm tree and can be sent separately.

Thanks for explanation. As fair as I understand, Bartlomiej wanted to
merge this in a way which would avoid loosing the boost mode. Kukjin
prepared topic branches for previous cpu-freq/clk stuff so maybe
everything could go through PM?

Kukjin, are you fine with that?

Best regards,
Krzysztof

