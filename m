From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 04/17] PM / OPP: Introduce
 dev_pm_opp_get_max_volt_latency()
Date: Thu, 21 Jan 2016 08:02:46 +0530
Message-ID: <20160121023246.GB15981@vireshk>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <08691b482198b0709fd258d310a5e6ecda2f1a18.1450777582.git.viresh.kumar@linaro.org>
 <20160112012512.GJ22188@codeaurora.org>
 <20160112051058.GJ1084@ubuntu>
 <20160112194537.GZ22188@codeaurora.org>
 <20160113053447.GB6050@ubuntu>
 <20160121002032.GD12841@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34151 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbcAUCcu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2016 21:32:50 -0500
Received: by mail-pa0-f47.google.com with SMTP id uo6so15003012pac.1
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2016 18:32:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160121002032.GD12841@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 20-01-16, 16:20, Stephen Boyd wrote:
> Ok, first off, I don't understand why the regulator and clock
> pointers are in the struct device_opp instead of the struct
> device_list_opp. I thought we wanted to make it possible for two
> devices to share the same OPP table (device_opp), but have
> physically different clocks and regulators (non opp-shared case)?
> If we put the clock and regulator handles in the device_opp then
> the opp table is limited to one device or a set of devices that
> all share the same clock and regulators.

Not exactly. We wanted devices (with separate rails) to share the OPP
tables ONLY IN DT. So that the same thing isn't required to be copied
multiple times in DT, for example in case of Krait.

But the code isn't supposed to shared device_opp structure at all.
There is one device_opp structure for a groups of devices that share
their OPPs and their clock/voltage rails. opp_device_list is
representing individual devices that share the same device_opp thing.

And this works pretty well and I don't think we should touch it now.

> BTW, these structure names confuse me all the time. I have to
> rename dev_pm_opp to opp_entry, device_opp to opp_table, and
> device_list_opp to opp_device_list in my head for anything to
> make sense.

Sure, we can (should) rename them after this series goes in.

> Gripes aside, the clock and regulator pointers should never be
> 'put' and go away until the device driver that's using the
> dev_pm_opp_set_rate() API has called dev_pm_opp_remove().

Right.

> So any
> concerns about that happening during an OPP switch aren't the
> concern of the OPP framework, but the concern of the consumer
> drivers having the proper locking and tear down sequences.

I am fine with that view as well.. It simplifies lots of things for me
:)

-- 
viresh
