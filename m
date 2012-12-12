From: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Subject: Re: [RFC PATCH] ARM: EXYNOS5: Support Exynos5-bus devfreq driver
Date: Wed, 12 Dec 2012 08:33:29 +0530
Message-ID: <CAM4voakRaNU-7=vF1+e8RAu14XP6NKWMmjiCRHgzn14B4SH8rQ@mail.gmail.com>
References: <1355141166-17205-1-git-send-email-a.kesavan@samsung.com>
	<001701cdd732$53119410$f934bc30$%choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <001701cdd732$53119410$f934bc30$%choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonghwan Choi <jhbird.choi@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, kgene.kim@samsung.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rjw@sisk.pl
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 11, 2012 at 5:29 AM, Jonghwan Choi <jhbird.choi@samsung.com> wrote:
> Hi Abhilash Kesavan.
Hi Mr Choi,

Thanks for your comments.
>
>
>> +     /* Change Divider - LEX */
>> +     tmp = __raw_readl(EXYNOS5_CLKDIV_LEX);
>> +
>> +     tmp &= ~(EXYNOS5_CLKDIV_LEX_ATCLK_LEX_MASK |
>> +             EXYNOS5_CLKDIV_LEX_PCLK_LEX_MASK);
>> +
>> +     tmp |= int_freq[div_index].clk_div_lex;
>> +
>> +     __raw_writel(tmp, EXYNOS5_CLKDIV_LEX);
>> +
>
> I knew that only ATCLK_LEX & PCLK_LEX divider value are in CLKDIV_LEX
> register. (Others are reserved and value is 0)
> So, I think
> "
> tmp = int_freq[div_index].clk_div_lex;
> __raw_writel(tmp, EXYNOS5_CLKDIV_LEX);
> "
> Is enough.
>
>> +     tmp = __raw_readl(EXYNOS5_CLKDIV_LEX);
>> +
>> +     tmp &= ~(EXYNOS5_CLKDIV_LEX_ATCLK_LEX_MASK |
>> +             EXYNOS5_CLKDIV_LEX_PCLK_LEX_MASK);
> -> not need.
>
>
>
>> +     while (__raw_readl(EXYNOS5_CLKDIV_STAT_LEX) & 0x110)
>> +             cpu_relax();
>> +
>> +     /* Change Divider - R0X */
>> +     tmp = __raw_readl(EXYNOS5_CLKDIV_R0X);
>> +
>> +     tmp &= ~EXYNOS5_CLKDIV_R0X_PCLK_R0X_MASK;
>> +
>> +     tmp |= int_freq[div_index].clk_div_r0x;
>> +
>> +     __raw_writel(tmp, EXYNOS5_CLKDIV_R0X);
>> +
>
> Same here
>
>
>> +     while (__raw_readl(EXYNOS5_CLKDIV_STAT_R0X) & 0x10)
>> +             cpu_relax();
>> +
>> +     /* Change Divider - R1X */
>> +     tmp = __raw_readl(EXYNOS5_CLKDIV_R1X);
>> +
>> +     tmp &= ~EXYNOS5_CLKDIV_R1X_PCLK_R1X_MASK;
>> +
>> +     tmp |= int_freq[div_index].clk_div_r1x;
>> +
>> +     __raw_writel(tmp, EXYNOS5_CLKDIV_R1X);
>> +
>
> Same here
>
>> +     while (__raw_readl(EXYNOS5_CLKDIV_STAT_R1X) & 0x10)
>> +             cpu_relax();
>
> How about your opinion?
I have verified the registers against the 5250 User Manual. You are
right on all counts.
I will fix them all and re-post.
>
> thanks
Regards,
Abhilash
