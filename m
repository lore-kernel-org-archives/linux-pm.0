From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 3/3] firmware: scpi: add device power domain support
 using genpd
Date: Thu, 16 Jun 2016 18:59:13 +0100
Message-ID: <5762E8F1.1040401@arm.com>
References: <1466073481-697-1-git-send-email-sudeep.holla@arm.com>
 <1466073481-697-4-git-send-email-sudeep.holla@arm.com>
 <1466099274.20208.65.camel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466099274.20208.65.camel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>
List-Id: linux-pm@vger.kernel.org



On 16/06/16 18:47, Jon Medhurst (Tixy) wrote:
> On Thu, 2016-06-16 at 11:38 +0100, Sudeep Holla wrote:
> [...]
>> +enum scpi_power_domain_state {
>> +	SCPI_PD_STATE_ON = 0,
>> +	SCPI_PD_STATE_OFF = 3,
>> +};
>
> The SCPI doc defines the meaning of these numbers (0 and 3) in the 'Juno
> specifics' chapter. So does these values need to come from device-tree
> to allow for other hardware or SCP implementations?
>

Ah unfortunately true :(. I had not noticed that. But I would like to
check if this can be made as part of the standard protocol. Adding such
details to DT seems overkill and defeat of the whole purpose of the
standard protocol.

-- 
Regards,
Sudeep
