From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq and boost with amd ryzen
Date: Wed, 5 Jul 2017 09:47:58 +0530
Message-ID: <20170705041758.GJ3532@vireshk-i7>
References: <CAFFvMK3sFE+zBu3k9vFRTBFVig70DQK8fpvSKiTXkw1bW+zF=A@mail.gmail.com>
 <CAOh2x=k87W_i88fXn7LeaMnMJVW8Jvn-jMAxm+Cg5db6xy3bpQ@mail.gmail.com>
 <CAFFvMK1zUZhKAqFMxSWjbW7Bb-j0Odr0DjmTiC8DbqKonNL+Kg@mail.gmail.com>
 <20170704061000.GE3532@vireshk-i7>
 <CAFFvMK1FuCUWjOk_hv9W+zTqWcDT86qNbybRrzx989d1gfoZKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34732 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750767AbdGEESD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jul 2017 00:18:03 -0400
Received: by mail-pg0-f45.google.com with SMTP id t186so118415515pgb.1
        for <linux-pm@vger.kernel.org>; Tue, 04 Jul 2017 21:18:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAFFvMK1FuCUWjOk_hv9W+zTqWcDT86qNbybRrzx989d1gfoZKw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sergio P <sergio.pieiga@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>

+Rafael,

On 04-07-17, 16:38, Sergio P wrote:
> To be honest, I am not very familiar on how to debug the kernel.
> 
> My guess would be that X86_FEATURE_CPB is not being detected correctly
> for Ryzen family in the CPUID registers, and it returns early from
> acpi_cpufreq_boost_init().  Also, CPB was a feature in earlier AMD
> processors, but now in the new Ryzen family, I'm not sure if it's
> called something else and perhaps defined in a different CPUID bit.

@Rafael: Do you have any idea about the new Ryzen family or how to get boost
working on them ?

-- 
viresh
