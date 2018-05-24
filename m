From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v12 1/2] cpufreq: Add Kryo CPU scaling driver
Date: Thu, 24 May 2018 15:01:15 +0100
Message-ID: <b4e221af-57f7-fd11-942d-6bc6f6b55a73@arm.com>
References: <1527152242-31281-1-git-send-email-ilialin@codeaurora.org>
 <1527152242-31281-2-git-send-email-ilialin@codeaurora.org>
 <860be68b-cac0-9efc-b3c7-cc75b391a4c3@arm.com>
 <000501d3f35f$96794910$c36bdb30$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <000501d3f35f$96794910$c36bdb30$@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: ilialin@codeaurora.org, vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, robh@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 24/05/18 14:03, ilialin@codeaurora.org wrote:
> 
> 

[...]

>>> +
>>> +	ret = PTR_ERR_OR_ZERO(platform_device_register_simple(
>>> +		"qcom-cpufreq-kryo", -1, NULL, 0));
>>
>>
>> You simply can't do this unconditionally here. This will blow up on platforms
>> where this driver is not supposed to work. The probe will be called on non-
>> QCOM or non-Kryo QCOM platforms and I reckon it will crash trying to
>> execute something in qcom_smem_get.
> 
> What do you mean by 'unconditionally'?

Why should you even add/register a device "qcom-cpufreq-kryo" on other
platforms. Drivers can get registered, but only devices that are present
or required by the platform need to be registered.

> The driver depends on the smem and nvmem drivers, which depend on ARCH_QCOM:
>  +	depends on QCOM_QFPROM
>  +	depends on QCOM_SMEM
> 

Sure, but we have something called single image for all ARM64 platforms.
May be QCOM still used to tweeking config to build binary for your
particular mobile platform but the distro kernel need single binary to
work on all platforms. We have moved far away from platform specific
builds long back now IIRC.

> And if SMEM read in the probe returns something other than Kryo, it will exit.
> 

Check what this driver does ?

	msm_id = qcom_smem_get(QCOM_SMEM_HOST_ANY, MSM_ID_SMEM, &len);
	msm_id++;
	switch ((enum _msm_id)*msm_id)

I think it *will and should* crash here ? You need to check the return
value for sure. But since qcom_smem_get return -EPROBE_DEFER, we keep
retrying even on non QCOM platforms which is something I would like to
avoid.

Therefore that's not the main concern. Why do I have to see
"qcom-cpufreq-kryo" device registered on my non QCOM platform ?

-- 
Regards,
Sudeep
