From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 04/17] PM / OPP: Introduce
 dev_pm_opp_get_max_volt_latency()
Date: Wed, 20 Jan 2016 18:43:26 -0800
Message-ID: <56A045CE.9050105@codeaurora.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <08691b482198b0709fd258d310a5e6ecda2f1a18.1450777582.git.viresh.kumar@linaro.org>
 <20160112012512.GJ22188@codeaurora.org> <20160112051058.GJ1084@ubuntu>
 <20160112194537.GZ22188@codeaurora.org> <20160113053447.GB6050@ubuntu>
 <20160121002032.GD12841@codeaurora.org> <20160121023246.GB15981@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58979 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756398AbcAUCna (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2016 21:43:30 -0500
In-Reply-To: <20160121023246.GB15981@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 01/20/2016 06:32 PM, Viresh Kumar wrote:
> On 20-01-16, 16:20, Stephen Boyd wrote:
>> Ok, first off, I don't understand why the regulator and clock
>> pointers are in the struct device_opp instead of the struct
>> device_list_opp. I thought we wanted to make it possible for two
>> devices to share the same OPP table (device_opp), but have
>> physically different clocks and regulators (non opp-shared case)?
>> If we put the clock and regulator handles in the device_opp then
>> the opp table is limited to one device or a set of devices that
>> all share the same clock and regulators.
> Not exactly. We wanted devices (with separate rails) to share the OPP
> tables ONLY IN DT. So that the same thing isn't required to be copied
> multiple times in DT, for example in case of Krait.
>
> But the code isn't supposed to shared device_opp structure at all.
> There is one device_opp structure for a groups of devices that share
> their OPPs and their clock/voltage rails. opp_device_list is
> representing individual devices that share the same device_opp thing.
>
> And this works pretty well and I don't think we should touch it now.
>
>

Ok. Thanks for clarifying. I see the code matches that description.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

