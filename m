From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 5/5] cpufreq:boost:Kconfig: Enable boost support at Kconfig
Date: Mon, 10 Jun 2013 18:52:33 +0530
Message-ID: <CAKohponR3HtHMkvCCdzmAS+MMe0CawRYr-ome=SO80nLVaWbeQ@mail.gmail.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
	<1370502472-7249-6-git-send-email-l.majewski@samsung.com>
	<20130606155815.GB21272@pd.tnic>
	<20130610152027.3133d1ab@amdc308.digital.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:55861 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752623Ab3FJNWd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jun 2013 09:22:33 -0400
Received: by mail-ob0-f169.google.com with SMTP id up14so10113002obb.0
        for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2013 06:22:33 -0700 (PDT)
In-Reply-To: <20130610152027.3133d1ab@amdc308.digital.local>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Borislav Petkov <bp@alien8.de>, "Rafael J. Wysocky" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

On 10 June 2013 18:50, Lukasz Majewski <l.majewski@samsung.com> wrote:
> Hi,
>
>> On Thu, Jun 06, 2013 at 09:07:52AM +0200, Lukasz Majewski wrote:
>> > Enable/disable support for BOOST. New flag - CPU_FREQ_BOOST has been
>> > defined for that.
>>
>> What's the reason for this? Why would you want to not compile-in the
>> boosting code?
>
> I think that this flag could be removed and the "boost" could be
> compiled-in permanently.
>
> Viresh, what is your opinion?

Yes, Borislav is correct. I haven't actually reviewed these last patches as
I saw lots of issues with first one :)
