From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] PM / Domains: Return -EPROBE_DEFER if we fail to init
 or turn-on domain
Date: Fri, 31 Jul 2015 10:20:38 +0100
Message-ID: <55BB3DE6.6050807@nvidia.com>
References: <1438070668-19956-1-git-send-email-jonathanh@nvidia.com> <7hvbd11azr.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17564 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbbGaJUu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2015 05:20:50 -0400
In-Reply-To: <7hvbd11azr.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org


On 31/07/15 00:28, Kevin Hilman wrote:
> [ sorry for the lag, been on vacation... ]
> 
> Hi Jon,
> 
> Jon Hunter <jonathanh@nvidia.com> writes:
> 
>> When a device is probed, the function dev_pm_domain_attach() is called
>> to see if there is a power-domain that is associated with the device and
>> needs to be turned on. If dev_pm_domain_attach() does not return
>> -EPROBE_DEFER then the device will be probed.
>>
>> For devices using genpd, dev_pm_domain_attach() will call
>> genpd_dev_pm_attach(). If genpd_dev_pm_attach() does not find a power
>> domain associated with the device then it returns an error code not
>> equal to -EPROBE_DEFER to allow the device to be probed. However, if
>> genpd_dev_pm_attach() does find a power-domain that is associated with
>> the device, then it does not return -EPROBE_DEFER on failure and hence
>> the device will still be probed. Furthermore, genpd_dev_pm_attach() does
>> not check the error code returned by pm_genpd_poweron() to see if the
>> power-domain was turned on successfully.
> 
> That's a good description of the problem, but doesn't describe the fix
> the fix.
> 
> Please summarize the solution being implemented here...

Ok, np.

>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> ... otherwise, patch itself looks fine.  Feel free to add
> 
> Acked-by: Kevin Hilman <khilman@linaro.org>

Thanks. I just send out an updated version.

Cheers Jon

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
