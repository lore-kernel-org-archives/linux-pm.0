From: Nandor Han <nandor.han@vaisala.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: power: reset: add document for NVMEM
 based reboot-mode
Date: Fri, 10 May 2019 15:49:36 +0300
Message-ID: <0134c853-f5eb-8d6f-6523-61688607b367@vaisala.com>
References: <fc60b885f1b447ce55950184c7921cfc1c96ade6>
 <20190421190913.1478-3-nandor.han@vaisala.com> <20190430224731.GA31760@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190430224731.GA31760@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "sre@kernel.org" <sre@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 5/1/19 1:47 AM, Rob Herring wrote:

Hi Rob,
   Thanks for review.

>> @@ -0,0 +1,32 @@
>> +NVMEM reboot mode driver
>> +
>> +This driver gets reboot mode magic value from reboot-mode driver
>> +and stores it in a NVMEM cell named "reboot-mode". Then the bootloader
>> +can read it and take different action according to the magic
>> +value stored.
> 
> This is also assuming the nvmem is writeable which is more often not the
> case.
> 
> Is your usecase a platform that supports pstore? Adding on to that
> binding might be a better fit.
> 

I'm using an RTC persistent memory for storing this data. The available
memory is low and don't think pstore will fit in this case.

>> +The rest of the properties should follow the generic reboot-mode description
>> +found in reboot-mode.txt
>> +
>> +Example:
>> +	reboot-mode-nvmem@0 {
> 
> What's this node for?
> 
>> +		compatible = "simple-mfd";
> 
> I only see 1 function.
> 

No need to this. Will remove

Nandor
