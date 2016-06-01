From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] thermal: cpu_cooling: fix improper order during
 initialization
Date: Wed, 1 Jun 2016 16:40:34 +0530
Message-ID: <20160601111034.GO3725@vireshk-i7>
References: <1464690722-27996-1-git-send-email-lukasz.luba@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35842 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932394AbcFALKn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2016 07:10:43 -0400
Received: by mail-pf0-f179.google.com with SMTP id f144so13431734pfa.3
        for <linux-pm@vger.kernel.org>; Wed, 01 Jun 2016 04:10:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1464690722-27996-1-git-send-email-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, javi.merino@arm.com, amit.kachhap@gmail.com, rui.zhang@intel.com, edubezval@gmail.com

On 31-05-16, 11:32, Lukasz Luba wrote:
> The freq_table array is not populated before calling
> thermal_of_cooling_register. The code which populates the freq table was
> introduced in commit f6859014.
> This should be done before registering new thermal cooling device.
> The log shows effects of this wrong decision.
> [    2.172614] cpu cpu1: Failed to get voltage for frequency 1984518656000: -34
> [    2.220863] cpu cpu0: Failed to get voltage for frequency 1984524416000: -34
> 

You should have added this as well:

Cc: 4.19+ <stable@vger.kernel.org> # 4.19+
Fixes: f6859014c7e7 ("thermal: cpu_cooling: Store frequencies in descending order")

> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/cpu_cooling.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
