From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: exynos: Initialise return variable
Date: Wed, 23 Jan 2013 08:57:06 +0530
Message-ID: <CAK9yfHxUnW5QV15dKnOGbLBuZWt6PV48=HN=2FpqMrBsV0Tisw@mail.gmail.com>
References: <1358764194-22753-1-git-send-email-sachin.kamat@linaro.org>
	<2641184.NcZpVXpRem@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <2641184.NcZpVXpRem@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, jhbird.choi@samsung.com, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-pm@vger.kernel.org

+cc Kukjin

On 22 January 2013 19:29, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Monday, January 21, 2013 03:59:53 PM Sachin Kamat wrote:
>> 'ret' is undefined when the function returns from the first
>> error condition. Without this patch we get the following warning:
>>
>> drivers/cpufreq/exynos-cpufreq.c: In function =91exynos_target=92:
>> drivers/cpufreq/exynos-cpufreq.c:182:2: warning:
>> =91ret=92 may be used uninitialized in this function [-Wuninitialize=
d]
>
> I'd prefer these two patches to go through the Exynos tree.

OK. I will post them to the Samsung list.

>
> Thanks,
> Rafael
>
>

--=20
With warm regards,
Sachin
