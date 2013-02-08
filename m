From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/3] cpufreq: exynos: Adding cpufreq driver for exynos5440
Date: Fri, 8 Feb 2013 09:53:05 +0530
Message-ID: <CAKohponiPmGWtDOVXLe48dvZYweguaEmNb3b_7h+Agb3gxQLOQ@mail.gmail.com>
References: <1360179562-19950-1-git-send-email-amit.daniel@samsung.com>
	<1360179562-19950-2-git-send-email-amit.daniel@samsung.com>
	<CAOh2x=kYM8n8XipvQ0-3H5f=B2TwAeFSa0DP=hy+SWQvPXJh6Q@mail.gmail.com>
	<CADGdYn7+U1fvFdHkAikoH9P-owF0ZKk6ZSgrPfY+16S3vO=S3A@mail.gmail.com>
	<CAKohpon1J+7ZQu+Nevz_KBXpVa2Kus--DxR3cOhb97o-scB0fw@mail.gmail.com>
	<CADGdYn7FHa0Gnntpjs-K6T421=F0rZEhjyg-mkcsb_YDA6SZWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:39787 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759778Ab3BHEXH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Feb 2013 23:23:07 -0500
Received: by mail-ob0-f171.google.com with SMTP id x4so3376575obh.16
        for <linux-pm@vger.kernel.org>; Thu, 07 Feb 2013 20:23:06 -0800 (PST)
In-Reply-To: <CADGdYn7FHa0Gnntpjs-K6T421=F0rZEhjyg-mkcsb_YDA6SZWQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: amit kachhap <amit.kachhap@gmail.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kgene.kim@samsung.com, Thomas Abraham <thomas.abraham@linaro.org>, cpufreq@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>

On 8 February 2013 08:56, amit kachhap <amit.kachhap@gmail.com> wrote:
>>>>> +       dvfs_info->dvfs_init = true;
>>>>
>>>> why do you need this ?
>>> This is added to synchronize the interrupts.
>>
>> How? You are setting it once in init() and not touching it afterwards. :)
>
> Yes but during init also if interrupts starts arriving before complete
> initialization so to protect that case it is there. I suppose there
> are other ways. Will check them

Then clear any pending interrupts from init ()
