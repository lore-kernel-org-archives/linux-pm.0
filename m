From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5 08/11] ARM: STi: Register CPUFreq device
Date: Wed, 9 Dec 2015 14:49:07 +0530
Message-ID: <20151209091907.GF28374@ubuntu>
References: <1449585124-15596-1-git-send-email-lee.jones@linaro.org>
 <1449585124-15596-9-git-send-email-lee.jones@linaro.org>
 <3682335.fAt9xNcJFr@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36106 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389AbbLIJTN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2015 04:19:13 -0500
Received: by pfdd184 with SMTP id d184so27170665pfd.3
        for <linux-pm@vger.kernel.org>; Wed, 09 Dec 2015 01:19:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <3682335.fAt9xNcJFr@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, kernel@stlinux.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net, ajitpal.singh@st.com, maxime.coquelin@st.com

On 09-12-15, 10:15, Arnd Bergmann wrote:
> On Tuesday 08 December 2015 14:32:01 Lee Jones wrote:
> > @@ -161,3 +166,11 @@ struct smp_operations __initdata sti_smp_ops = {
> >         .smp_secondary_init     = sti_secondary_init,
> >         .smp_boot_secondary     = sti_boot_secondary,
> >  };
> > +
> > +/**
> > + * CPUFreq Registration
> > + */
> > +void init_cpufreq(void)
> > +{
> > +       platform_device_register_simple("sti-cpufreq", -1, NULL, 0);
> > +}
> > 
> 
> Can you please do this under drivers/cpufreq somewhere?
> 
> I really don't want to any more of these in platform code. Requiring a
> device to be created just to probe the driver is really silly.

He is actually creating two device right now..

- create sti-cpufreq device
  - so that sti-cpufreq driver get probed
    - And fix OPPs here first and then create cpufreq-dt device
      - so that cpufreq-dt driver get probed

:)

I already recommended him that he can replace the first two points by
doing things from module_init() instead. And then create cpufreq-dt
device.

-- 
viresh
