From: Bastian Stender <bst@pengutronix.de>
Subject: Re: [PATCH] cpufreq: imx6q: add CPU as cooling device
Date: Wed, 15 Nov 2017 10:09:06 +0100
Message-ID: <9b2c7392-683c-c005-7f5c-0e56dba38074@pengutronix.de>
References: <20171114135128.6173-1-bst@pengutronix.de>
 <20171115045956.GG3257@vireshk-i7>
 <6926d893-53ca-7719-f530-0406148f8fde@pengutronix.de>
 <20171115090623.GJ3257@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:56565 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751189AbdKOJJL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2017 04:09:11 -0500
In-Reply-To: <20171115090623.GJ3257@vireshk-i7>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Eduardo Valentin <edubezval@gmail.com>, kernel@pengutronix.de, Zhang Rui <rui.zhang@intel.com>, shawnguo@kernel.org

On 11/15/2017 10:06 AM, Viresh Kumar wrote:
> On 15-11-17, 10:04, Bastian Stender wrote:
>> Yes, I looked how drivers/cpufreq/mediatek-cpufreq.c handles the cooling
>> device. So dev_pm_opp_free_cpufreq_table is obviously not needed, but why do
>> we need no cpufreq_cooling_unregister call here?
> 
> My comment was only for the last line, i.e. dev_pm_opp_free_cpufreq_table(). Of
> course we need to use cpufreq_cooling_unregister() as you pointed out.

Alright.

Regards,
Bastian

-- 
Pengutronix e.K.
Industrial Linux Solutions
http://www.pengutronix.de/
Peiner Str. 6-8, 31137 Hildesheim, Germany
Amtsgericht Hildesheim, HRA 2686
