From: Mason <slash.tmp@free.fr>
Subject: Re: [PATCH V1 Resend 2/3] cpufreq: dt: Add generic platform-device
 creation support
Date: Fri, 1 Apr 2016 14:30:24 +0200
Message-ID: <56FE69E0.1080800@free.fr>
References: <cover.1459233524.git.viresh.kumar@linaro.org>
 <12972545.Mi9sHiNJpR@wuerfel> <20160330032240.GB8773@vireshk-i7>
 <7250220.227umpmTug@wuerfel> <20160401102350.GA5532@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:7705 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752761AbcDAMap (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 1 Apr 2016 08:30:45 -0400
In-Reply-To: <20160401102350.GA5532@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linaro-kernel@lists.linaro.org, k.kozlowski@samsung.com, kgene.kim@samsung.com, heiko@sntech.de, linux-pm@vger.kernel.org, mmcclint@codeaurora.org, xf@rock-chips.com, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, rob.herring@linaro.org, Sebastian Frias <sebastian_frias@sigmadesigns.com>

On 01/04/2016 12:23, Viresh Kumar wrote:

> Cc'ing Rob and Mason.
> 
> On 30-03-16, 09:53, Arnd Bergmann wrote:
>
>> I think it should be something in the /cpus or the /opp_table hierarchy,
>> not the root of the device tree, but other than that I don't care much
>> whether it's a variation of the oppv2 compatible string or an additional
>> property in any of the nodes.
> 
> So you mean for future DT files we can have something like this:
> 
> 	cpus {
>               compatible = "operation-points-v2";
>               [...]
> 
> And the cpufreq-dt driver can match /cpus node's compatible string against
> "operating-points-v2" and create a device at runtime ?

Hmmm... I'm using the older operating-points prop in my platform's DT.
Why can't we define a new property (e.g. "enable-generic-cpufreq")
which registers the "cpufreq-dt" pseudo-device?

And platforms that manually register "cpufreq-dt" would be
automatically white-listed, even if they don't have the new
property, to maintain backward-compat?

> @Rob: Will that be acceptable to you? We are discussing (again) about how to
> probe cpufreq-dt driver automatically for platforms :)
> 
> The cpus node doesn't have any 'compatible' property today, and I will be
> required to add that in this case.

Why does it need a compatible prop?
Why isn't a bool prop enough?

Regards.

