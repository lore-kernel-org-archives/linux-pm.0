From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v5 0/4] cpufreq-dt: add suspend frequency support
Date: Mon, 14 Sep 2015 16:19:45 +0900
Message-ID: <55F67511.5000908@samsung.com>
References: <1441730464-7947-1-git-send-email-b.zolnierkie@samsung.com>
 <2547413.Uj7KDUeGpY@vostro.rjw.lan> <55F6728A.2070805@samsung.com>
 <20150914071727.GB32551@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20150914071727.GB32551@linux>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 14.09.2015 16:17, Viresh Kumar wrote:
> On 14-09-15, 16:08, Krzysztof Kozlowski wrote:
>> If you want, the fourth patch can go now through your tree - the late
>> SoC changes were pulled by Linus. No difference... I can grab it as I
>> had other DT related fix in queue.
>>
>> The only important thing is to get entire patchset to 4.3 because it is
>> a fix for regression introduced in cpufreq for exynos. Do you plan to
>> send your part in current 4.3 cycle?
> 
> The first 3 patches are already part for 4.3-rc1 and so you can keep
> the DT update in your tree now. :)

Damn it, I missed it. It solves everything, the fourth patch will go
through platform tree.

Best regards,
Krzysztof
