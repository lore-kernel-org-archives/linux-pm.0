From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 2/3] cpufreq: Remove unused function __cpufreq_driver_getavg
Date: Wed, 5 Jun 2013 14:12:11 +0530
Message-ID: <CAKohpokhSd7fvWvCtWDAybdYVhR55cXyEJzLH72hL9K-m_USKA@mail.gmail.com>
References: <51ACF2F1.1050600@semaphore.gr>
	<CAKohpomTRdHdKN3QUf0ba+gFXrEr=PbD4cJc8NSyNPmxfnUsMQ@mail.gmail.com>
	<51AE025C.9030401@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:58562 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414Ab3FEImM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2013 04:42:12 -0400
Received: by mail-oa0-f46.google.com with SMTP id h2so891458oag.19
        for <linux-pm@vger.kernel.org>; Wed, 05 Jun 2013 01:42:11 -0700 (PDT)
In-Reply-To: <51AE025C.9030401@semaphore.gr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, linux-kernel@vger.kernel.org

On 4 June 2013 20:36, Stratos Karafotis <stratosk@semaphore.gr> wrote:
> On 06/04/2013 08:19 AM, Viresh Kumar wrote:
>> Should this be done in 3/3 ?
>>
>
> acpi-cpufreq does not use mperf after 2/3. Why should we compile it with
> CONFIG_X86_ACPI_CPUFREQ?
> Do you want me to move the change in 3/3?

I somehow feel now that 3/3 should come before 2/3 and then this change
should be merged into it. And at the end we can have this patch as 3/3..

What do you say? core should go last and users/drivers must go first.
