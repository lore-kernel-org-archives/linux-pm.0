From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] thermal: of: Allow selection of thermal governor in DT
Date: Tue, 6 Mar 2018 12:32:08 +0000
Message-ID: <6d5aeab8-aafe-fa3b-585e-953a34864e7d@arm.com>
References: <cover.1520274879.git.amit.kucheria@linaro.org>
 <3b80853abb45a9e067cf7a16754b07bb67712457.1520274879.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3b80853abb45a9e067cf7a16754b07bb67712457.1520274879.git.amit.kucheria@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ram Chandrasekar <rkumbako@codeaurora.org>
Cc: Amit Kucheria <amit.kucheria@linaro.org>, devicetree@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, ilina@codeaurora.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 05/03/18 18:36, Amit Kucheria wrote:
> From: Ram Chandrasekar <rkumbako@codeaurora.org>
> 
> There is currently no way for the governor to be selected for each thermal
> zone in devicetree. 

How is that any different from cpufreq, cpuidle or devfreq subsystems ?

> This results in the default governor being used for all
> thermal zones even though no such restriction exists in the core code.
> 

What restrictions ?

> Add support for specifying the thermal governor to be used for a thermal
> zone in the devicetree.

Then what prevents us from doing the same for other subsystems with so
called /inefficient default/ governors ?

> The devicetree config should specify the governor
> name as a string that matches any available governors. If not specified, we
> maintain the current behaviour of using the default governor.

If one is specified, can the user change it from sysfs ? If
yes, then why do we need this binding at all ? If no, we are basically
restricting, then what would happen if the DT was shipped with wrong
governor specified because the firmware author didn't know about any
other governor ?

IMO, having this in DT is bad idea as it may cause more issues than
gain. We already have sysfs support like other PM subsystems and
userspace can deal with it.

-- 
Regards,
Sudeep
