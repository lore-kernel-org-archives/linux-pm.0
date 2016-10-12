From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 6/6] cpufreq: pxa: convert to clock API
Date: Wed, 12 Oct 2016 21:12:26 +0200
Message-ID: <87eg3l755x.fsf@belgarion.home>
References: <1476130149-31834-1-git-send-email-robert.jarzmik@free.fr>
        <1476130149-31834-7-git-send-email-robert.jarzmik@free.fr>
        <20161012023601.GC19385@vireshk-i7> <87mvia6q8p.fsf@belgarion.home>
        <20161012063247.GH19385@vireshk-i7> <87insy6kdq.fsf@belgarion.home>
        <20161012084044.GK19385@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:51015 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753712AbcJLTMc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Oct 2016 15:12:32 -0400
In-Reply-To: <20161012084044.GK19385@vireshk-i7> (Viresh Kumar's message of
        "Wed, 12 Oct 2016 14:10:44 +0530")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Viresh Kumar <viresh.kumar@linaro.org> writes:

>> >> PXA architecture have both legacy platform_data based configurations and new
>> >> devicetree based ones.
>> >
>> > I don't see any platform data specific code in this driver. What am I
>> > missing ?
>> 
>> In a legacy platform, ie. without devicetree, we have CONFIG_OF=n.
>> How would cpufreq-dt be usable in this case ?
>> 
>> You can see such a platform in arch/arm/configs/mainstone_defconfig and
>> arch/arm/mach-pxa/mainstone.c as an example.
>
> Okay, so its not about platform_data as you said earlier. Rather it is
> about the CONFIG_OF option.
We're bickering about terminology.

Mine is that there are globally :
 - platform_data _based_  configurations
   => drivers probing devices rely on platform_data structures for initial
   configuration
   => that implies CONFIG_OF=n
   => pxa2xx-cpufreq is one of them, even if in this case no platform_data is
   used
   
 - devicetree based configurations
   => drivers probing devices rely on device-tree blob for initial configuration
   => that implies CONFIG_OF=y

 - ACPI based configurations
   => drivers probing devices rely on ACPI data

 - maybe PCI would deserve a place, but I don't think there is much
   configuration in it

> In that case, what about making this driver depends_on !CONFIG_OF ? So
> that the DT users don't use it anymore.
Good idea, let me try it.
I'll see if it actually works before make another iteration of this patch.

Cheers.

-- 
Robert
