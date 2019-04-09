From: Abhishek <huntbag@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/2] cpuidle : auto-promotion for cpuidle states
Date: Tue, 9 Apr 2019 15:06:47 +0530
Message-ID: <f8a0e5ad-44d1-9a12-1995-57f3671a5889@linux.vnet.ibm.com>
References: <20190405091647.4169-1-huntbag@linux.vnet.ibm.com>
 <20190405091647.4169-2-huntbag@linux.vnet.ibm.com>
 <87lg0kwp3t.fsf@dja-thinkpad.axtens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87lg0kwp3t.fsf@dja-thinkpad.axtens.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, daniel.lezcano@linaro.org, mpe@ellerman.id.au, ego@linux.vnet.ibm.com
List-Id: linux-pm@vger.kernel.org

Hi Daniel,

On 04/08/2019 07:55 PM, Daniel Axtens wrote:
> Hi,
>
> Sorry, just realised another thing I wanted to ask:
>
>> @@ -442,6 +442,26 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>>   		}
>>   	}
>>
>>
>> +#ifdef CPUIDLE_FLAG_AUTO_PROMOTION
> Why is this based on CPUIDLE_FLAG_ rather than CONFIG_CPU_IDLE_? Won't
> this always be true, given that the flag is defined regardless of the
> config option in the header?
Yeah, You are right. This should have been CONFIG_CPU_IDLE_AUTO_PROMOTION.

--Abhishek
