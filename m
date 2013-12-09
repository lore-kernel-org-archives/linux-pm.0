From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v3] cpufreq: exynos: Convert exynos-cpufreq to platform
 driver
Date: Mon, 09 Dec 2013 09:28:09 +0100
Message-ID: <20131209092809.691fb0f9@amdc2363>
References: <1381939238-30398-1-git-send-email-t.figa@samsung.com>
 <1385642562-9339-1-git-send-email-l.majewski@samsung.com>
 <CAK9yfHyFXHiTmYeS6N-rTktHPsXNC3SGE8-yyZW4i-txQXo1+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <CAK9yfHyFXHiTmYeS6N-rTktHPsXNC3SGE8-yyZW4i-txQXo1+w@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sachin Kamat <sachin.kamat@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael, Vires,

> On 28 November 2013 18:12, Lukasz Majewski <l.majewski@samsung.com>
> wrote:
> > To make the driver multiplatform-friendly, unconditional
> > initialization in an initcall is replaced with a platform driver
> > probed only if respective platform device is registered.
> >
> > Tested at: Exynos4210 (TRATS) and Exynos4412 (TRATS2)
> >
> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Looks good to me.
> Reviewed-by: Sachin Kamat <sachin.kamat@linaro.org>
> 
> Tested on Exynos5250 board.
> Tested-by: Sachin Kamat <sachin.kamat@linaro.org>
> 
> Btw, Lukasz, can you please review my patch [1] which is similar to
> your changes done for 4210/4412.
> 
> [1] http://www.spinics.net/lists/linux-samsung-soc/msg24397.html
> 

Any comments on this patch? Is it suitable for pulling?


-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
