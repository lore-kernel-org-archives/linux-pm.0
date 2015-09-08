From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v4 0/4] cpufreq-dt: add suspend frequency support
Date: Tue, 08 Sep 2015 13:48:18 +0900
Message-ID: <55EE6892.3010304@samsung.com>
References: <1441640501-13613-1-git-send-email-b.zolnierkie@samsung.com>
 <20150908024659.GF26760@linux> <55EE5C79.2030604@samsung.com>
 <20150908042017.GJ26760@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-reply-to: <20150908042017.GJ26760@linux>
Sender: linux-clk-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kukjin Kim <kgene@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 08.09.2015 13:20, Viresh Kumar wrote:
> On 08-09-15, 12:56, Krzysztof Kozlowski wrote:
>> There were no comments from your side for this patchset nor for previous
>> Marek's fix. After mentioned change and Bart's re-spin, do you plan to
>> grab this patchset and send it for current v4.3 cycle?
> 
> Why do you think it should go via Kukjin's tree and not Rafael's?

Somehow my mind stuck on solving Exynos4x12 cpufreq issues.

Right, it should go through Rafael's, probably except DTS patch (4/4)
because it depends on previous DTS changes. These changes are still in
arm-soc, not in Linus' tree [0].

Best regards,
Krzysztof

[0]
https://git.kernel.org/cgit/linux/kernel/git/arm/arm-soc.git/commit/?h=next/late&id=f44997412e5b39b6a1231f16555120c5b2aae0ed
