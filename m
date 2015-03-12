From: Vince Hsu <vinceh@nvidia.com>
Subject: Re: [PATCH v2 17/17] soc/tegra: remove lagacy powergate APIs
Date: Thu, 12 Mar 2015 21:11:52 +0800
Message-ID: <55019098.3020901@nvidia.com>
References: <1426162518-7405-1-git-send-email-vinceh@nvidia.com> <1426162518-7405-18-git-send-email-vinceh@nvidia.com> <20150312124501.GA632@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9860 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753787AbbCLNNp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2015 09:13:45 -0400
In-Reply-To: <20150312124501.GA632@ulmo>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: pdeschrijver@nvidia.com, swarren@wwwdotorg.org, gnurou@gmail.com, jroedel@suse.de, p.zabel@pengutronix.de, mturquette@linaro.org, pgaikwad@nvidia.com, sboyd@codeaurora.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tbergstrom@nvidia.com, airlied@linux.ie, bhelgaas@google.com, tj@kernel.org, arnd@arndb.de, robh@kernel.org, will.deacon@arm.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org

Hi,

On 03/12/2015 08:45 PM, Thierry Reding wrote:
> * PGP Signed by an unknown key
>
> On Thu, Mar 12, 2015 at 08:15:18PM +0800, Vince Hsu wrote:
>> We switch to generic power domain now. So remove the legacy functions.
>>
>> Signed-off-by: Vince Hsu <vinceh@nvidia.com>
>> ---
>>   drivers/soc/tegra/pmc.c | 68 -------------------------------------------------
>>   include/soc/tegra/pmc.h | 22 ----------------
>>   2 files changed, 90 deletions(-)
> I don't think we can do this. What if somebody updates their kernel but
> not the DTB? In that case they'll end up with drivers that don't enable
> power partitions but at the same time the powergate driver won't enable
> them either because it is missing the corresponding nodes in the DTB.
You're right.

>
> What we'll have to do is probably keep the code that enables the power
> partitions and make it conditional on the power domains somehow. Is
> there a way to determine at runtime whether a device has been attached
> to a power domain?
>
Yes, we can check if a power domain is bound to the GPD by DT in the 
legacy powergate code.

Thanks,
Vince
