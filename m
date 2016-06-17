From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 1/3] firmware: arm_scpi: add support for device power
 state management
Date: Fri, 17 Jun 2016 09:46:54 +0100
Message-ID: <5763B8FE.8010104@arm.com>
References: <1466073481-697-1-git-send-email-sudeep.holla@arm.com>
 <1466073481-697-2-git-send-email-sudeep.holla@arm.com>
 <1466100232.20208.73.camel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466100232.20208.73.camel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Suzuki K Poulose <suzuki.poulose@arm.com>
List-Id: linux-pm@vger.kernel.org



On 16/06/16 19:03, Jon Medhurst (Tixy) wrote:
> On Thu, 2016-06-16 at 11:37 +0100, Sudeep Holla wrote:
>> SCPI protocol supports device power state management. This deals with
>> power states of various peripheral devices in the system other than the
>> core compute subsystem.
>>
>> This patch adds support for the power state management of those
>> peripheral devices.
>>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>
> Reviewed-by: Jon Medhurst <tixy@linaro.org>
> Tested-by: Jon Medhurst <tixy@linaro.org>
>

Thanks a lot.

-- 
Regards,
Sudeep
