From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] thermal: cpu_cooling: fix improper order during
 initialization
Date: Wed, 1 Jun 2016 19:09:38 +0530
Message-ID: <20160601133938.GQ3725@vireshk-i7>
References: <1464690722-27996-1-git-send-email-lukasz.luba@arm.com>
 <20160601111034.GO3725@vireshk-i7>
 <574EE3B7.1060302@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36213 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750697AbcFANjm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2016 09:39:42 -0400
Received: by mail-pf0-f177.google.com with SMTP id f144so15576098pfa.3
        for <linux-pm@vger.kernel.org>; Wed, 01 Jun 2016 06:39:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <574EE3B7.1060302@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: edubezval@gmail.com, linux-pm@vger.kernel.org, javi.merino@arm.com, amit.kachhap@gmail.com, rui.zhang@intel.com

On 01-06-16, 14:31, Lukasz Luba wrote:
> 
> 
> On 01/06/16 12:10, Viresh Kumar wrote:
> >On 31-05-16, 11:32, Lukasz Luba wrote:
> >>The freq_table array is not populated before calling
> >>thermal_of_cooling_register. The code which populates the freq table was
> >>introduced in commit f6859014.
> >>This should be done before registering new thermal cooling device.
> >>The log shows effects of this wrong decision.
> >>[    2.172614] cpu cpu1: Failed to get voltage for frequency 1984518656000: -34
> >>[    2.220863] cpu cpu0: Failed to get voltage for frequency 1984524416000: -34
> >>
> >
> >You should have added this as well:
> >
> >Cc: 4.19+ <stable@vger.kernel.org> # 4.19+
> 
> You mean 3.19+
> Cc: <stable@vger.kernel.org> # 3.19+

Urg.

Thanks for fixing this :)

-- 
viresh
