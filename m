From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: exynos: Broadcast frequency change notifications
 for all cores
Date: Fri, 1 Feb 2013 09:17:59 +0530
Message-ID: <CAKohpo=5jPSaZMJOJTYpWiSBReRJrVayXhT7zQuFRYCR7S5hqg@mail.gmail.com>
References: <1887364.fvxYYNb7Mm@amdc1227>
	<1520678.Zm627xxIN3@amdc1227>
	<CAKohpomEcrPa7UnZmtTouxN6JXxcaa7dBstMGUWjXGL0n1+=Ng@mail.gmail.com>
	<1604688.EafV1ohaV9@amdc1227>
	<CAKohpo=_cR7dk_V2+6bQwUMk-raa3ENAJqBCSe_mYfS+Ur8PnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=_cR7dk_V2+6bQwUMk-raa3ENAJqBCSe_mYfS+Ur8PnA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On 31 January 2013 21:42, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 31 January 2013 21:37, Tomasz Figa <t.figa@samsung.com> wrote:
>> Hmm. Now as I think of it, there might be another confusing aspect:
>>
>> Could you explain what "sw coordination" and "any coordination" mean?
>> I mean specifically cpufreq_policy.cpus and cpufreq_policy.related_cpus
>> masks.
>
> Check this out:
>
> https://lkml.org/lkml/2013/1/30/587

You would really like to look and ack this one too:

https://lkml.org/lkml/2013/1/30/592
