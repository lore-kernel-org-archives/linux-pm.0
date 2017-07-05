From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: cpufreq and boost with amd ryzen
Date: Wed, 05 Jul 2017 13:01:32 +0200
Message-ID: <2081647.Fs5kDZcm2E@aspire.rjw.lan>
References: <CAFFvMK3sFE+zBu3k9vFRTBFVig70DQK8fpvSKiTXkw1bW+zF=A@mail.gmail.com> <CAFFvMK1FuCUWjOk_hv9W+zTqWcDT86qNbybRrzx989d1gfoZKw@mail.gmail.com> <20170705041758.GJ3532@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:56065 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751755AbdGELJN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jul 2017 07:09:13 -0400
In-Reply-To: <20170705041758.GJ3532@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sergio P <sergio.pieiga@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux PM list <linux-pm@vger.kernel.org>

On Wednesday, July 05, 2017 09:47:58 AM Viresh Kumar wrote:
> +Rafael,
> 
> On 04-07-17, 16:38, Sergio P wrote:
> > To be honest, I am not very familiar on how to debug the kernel.
> > 
> > My guess would be that X86_FEATURE_CPB is not being detected correctly
> > for Ryzen family in the CPUID registers, and it returns early from
> > acpi_cpufreq_boost_init().  Also, CPB was a feature in earlier AMD
> > processors, but now in the new Ryzen family, I'm not sure if it's
> > called something else and perhaps defined in a different CPUID bit.
> 
> @Rafael: Do you have any idea about the new Ryzen family or how to get boost
> working on them ?

Not from the top of my head, I need to look into the code.

In any case, IIRC, the boost and cpb attributes are mutually exclusive, so you
won't see the former if you see the latter.  I'm not sure how we decide which
one to expose, though.

Thanks,
Rafael
