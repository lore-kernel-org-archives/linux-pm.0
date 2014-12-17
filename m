From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v14 00/10] cpuidle driver for QCOM SoCs: 8064, 8074, 8084
Date: Wed, 17 Dec 2014 11:25:09 -0700
Message-ID: <20141217182509.GA1913@linaro.org>
References: <1417541958-56907-1-git-send-email-lina.iyer@linaro.org>
 <7hegryb0te.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:48631 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbaLQSZM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Dec 2014 13:25:12 -0500
Received: by mail-pd0-f170.google.com with SMTP id v10so16695627pde.1
        for <linux-pm@vger.kernel.org>; Wed, 17 Dec 2014 10:25:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7hegryb0te.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: daniel.lezcano@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org

On Wed, Dec 17 2014 at 11:14 -0700, Kevin Hilman wrote:
>Lina Iyer <lina.iyer@linaro.org> writes:
>
>> Dependent patchsets -
>>         https://lkml.org/lkml/2014/8/4/767
>>         http://www.spinics.net/lists/linux-arm-msm/msg10799.html
>>         http://www.spinics.net/lists/linux-arm-msm/msg10795.html
>>
>> Changes since v13:
>> - Return values for idle states propagated back to the cpuidle driver.
>> - Remove static bool cpuidle_drv_init.
>> - Register cpuidle driver and cpuidle device separately.
>>  - cpuidle device registered only when the SPM for the cpu is probed.
>> - Initialization changes to ensure dynamic cpuidle devices are registered only
>>   after the cpuidle driver is registered.
>> - Removed wmb, replaced with a poll loop to ensure that the SPM registers are
>>   written before executing wfi.
>>   - Added spm_register_write_sync() for write guarantees.
>> - Removed irrelevant return value for spm_set_low_power_mode().
>> - Added comments, updated module description.
>> - Removed Reviewed-by and Acked-by on the spm and cpuidle-qcom patches.
>
>I think this series should also include updates to qcom_defconfig that
>enable QCOM_PM and the cpuidle driver.
>
>Then it will be enabled by default and get more broad testing.

Sure. I will be enabling them in the next revision of the series.

>
>Kevin
