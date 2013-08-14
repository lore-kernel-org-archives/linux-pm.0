From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: Add governor operation ongoing flag
Date: Wed, 14 Aug 2013 14:24:36 +0530
Message-ID: <CAKohpokTA8iUbC8Jhd9Lqd4VbVqiEn-Ntu4jPvYHkbM1MbVM=A@mail.gmail.com>
References: <1376377766-2594-1-git-send-email-chenxg@marvell.com>
	<CAKohpo=QKPvqUcQVsbbSQdWOOi5L-P2CBFzcfMsobs8uGpLkVw@mail.gmail.com>
	<CAFgnuDes_F7Q5CHbXKC=ndrn9Gr3PJfGj0QvDXA-FuGcq41CHQ@mail.gmail.com>
	<CAKohponD2LdDsJy=UJCf-1yANjyPjmAyokV5a4HOSJn_DMJVhA@mail.gmail.com>
	<CAFgnuDetTVYayBABNPhME15b+b6qUtJX2hBaJ6y4+gOSgGFwdQ@mail.gmail.com>
	<CAKohpoksGB6bBtFF4DaqqLME2kpDve5uMycZDCXahaigdRhwKQ@mail.gmail.com>
	<CAFgnuDe1VwH2_xyyRN382=gGO8N6QKONKpGkLBGK8Hv2Zh1orA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAFgnuDe1VwH2_xyyRN382=gGO8N6QKONKpGkLBGK8Hv2Zh1orA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Xiaoguang Chen <chenxg.marvell@gmail.com>
Cc: Xiaoguang Chen <chenxg@marvell.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On 14 August 2013 14:20, Xiaoguang Chen <chenxg.marvell@gmail.com> wrote:
> Hi, Viresh
> After checking your patch, I find that __cpufreq_set_policy function
> doesn't check STOP and EXIT 's return value
> is it on purpose? if not, I can provide a patch to add it.

I thought we probably can't break on these calls here, while we are trying to
stop existing governor. And so didn't check return values..

If you face some issues with them, you are free to add checks.
