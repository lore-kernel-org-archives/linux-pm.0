From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 0/3] firmware: scpi: add device power domain support
Date: Fri, 17 Jun 2016 16:34:44 +0100
Message-ID: <57641894.5030504@arm.com>
References: <1466073481-697-1-git-send-email-sudeep.holla@arm.com>
 <CANLsYkwHMCSep-zBY+iQmCpGy2wvyegbb9pH70rv+iKsreSQwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANLsYkwHMCSep-zBY+iQmCpGy2wvyegbb9pH70rv+iKsreSQwA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Jon Medhurst <tixy@linaro.org>, Suzuki K Poulose <suzuki.poulose@arm.com>
List-Id: linux-pm@vger.kernel.org



On 17/06/16 16:22, Mathieu Poirier wrote:
> On 16 June 2016 at 04:37, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> This series add support for SCPI based device device power state
>> management using genpd.
>>
>> Regards,
>> Sudeep
>>
>> v1[1]->v2:
>>          - Fixed the endianness handling in scpi_device_get_power_state
>>            as spotted by Tixy
>>          - Renamed scpi_pd.c to scpi_pm_domain.c as suggested by Ulf
>>          - Added Mark's ack on DT binding
>>
>> [1] https://marc.info/?l=linux-kernel&m=146522850003483&w=2
>>
>> Sudeep Holla (3):
>>    firmware: arm_scpi: add support for device power state management
>>    Documentation: add DT bindings for ARM SCPI power domains
>>    firmware: scpi: add device power domain support using genpd
>>
>>   Documentation/devicetree/bindings/arm/arm,scpi.txt |  34 +++++
>>   drivers/firmware/Kconfig                           |   9 ++
>>   drivers/firmware/Makefile                          |   1 +
>>   drivers/firmware/arm_scpi.c                        |  30 ++++
>>   drivers/firmware/scpi_pm_domain.c                  | 152 +++++++++++++++++++++
>>   include/linux/scpi_protocol.h                      |   2 +
>>   6 files changed, 228 insertions(+)
>>   create mode 100644 drivers/firmware/scpi_pm_domain.c
>>
>> --
>> 2.7.4
>>
>
> For the set:
>
> Tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>

Thanks for testing.

-- 
Regards,
Sudeep
