From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v10 07/10] qcom: cpuidle: Add cpuidle driver for QCOM cpus
Date: Wed, 26 Nov 2014 11:43:01 -0800
Message-ID: <7hegspeoje.fsf@deeprootsystems.com>
References: <1416593037-27527-1-git-send-email-lina.iyer@linaro.org>
	<1416593037-27527-8-git-send-email-lina.iyer@linaro.org>
	<5475A599.1010601@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <5475A599.1010601@linaro.org> (Daniel Lezcano's message of "Wed,
	26 Nov 2014 11:04:09 +0100")
Sender: linux-arm-msm-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lina Iyer <lina.iyer@linaro.org>, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> On 11/21/2014 07:03 PM, Lina Iyer wrote:
>> Add cpuidle driver interface to allow cpus to go into C-States. Use the
>> cpuidle DT interface, common across ARM architectures, to provide the
>> idle state information to the cpuidle framework.
>>
>> Supported modes at this time are Standby and Standalone Power Collapse.
>>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>
> One nit and one comment below. Other than that:
>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> [ ... ]
>
>> +static int qcom_cpu_stby(struct cpuidle_device *dev,
>> +				struct cpuidle_driver *drv, int index)
>> +{
>> +	lpm_ops->standby(NULL);
>
> In my last comment I was referring about a check for entering
> successfully the idle state:
>
> 	if (lpm_ops->standby(NULL))
> 		return -1;
>
>> +	return index;
>> +}
>> +
>> +static int qcom_cpu_spc(struct cpuidle_device *dev,
>> +				struct cpuidle_driver *drv, int index)
>> +{
>> +	lpm_ops->spc(NULL);
>> +
>> +	return index;
 
Similar to Daniel's comment above.  if lpm_ops->spc() fails, do you want
to fall back to standby.

Hmm, using the DT idle states, it doesn't look as straight forward as it
used to be to fall back to a "safe state."

Kevin
