From: Nandor Han <nandor.han@vaisala.com>
Subject: Re: [PATCH v2 1/2] power: reset: nvmem-reboot-mode: use NVMEM as
 reboot mode write interface
Date: Thu, 18 Apr 2019 09:29:08 +0300
Message-ID: <b046dc29-002c-39a9-5a54-562c49adb691@vaisala.com>
References: <20190411055341.9263-1-nandor.han@vaisala.com>
 <20190411055341.9263-2-nandor.han@vaisala.com>
 <20190417215649.ejrvd6zekfmvjtn5@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190417215649.ejrvd6zekfmvjtn5@earth.universe>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 4/18/19 12:56 AM, Sebastian Reichel wrote:
> On Thu, Apr 11, 2019 at 05:54:09AM +0000, Han Nandor wrote:
>> Add a new reboot mode write interface that is using an NVMEM cell
>> to store the reboot mode magic.
>>
>> Signed-off-by: Nandor Han <nandor.han@vaisala.com>
>> ---

<snip>

>> +module_platform_driver(nvmem_reboot_mode_driver);
>> +
>> +MODULE_AUTHOR("Nandor Han <nandor.han@vaisala.com>");
>> +MODULE_DESCRIPTION("NVMEM reboot mode driver");
>> +MODULE_LICENSE("GPL v2");
> 
> I suppose as of bf7fbeeae6db "GPL v2" is deprecated, before it was
> often read as GPL v2 only. In both cases it makes sense to just
> use "GPL". Otherwise the driver looks fine to me, but I'm waiting
> for Rob's review of the DT bindings before merging this.
> 
> -- Sebastian
> 

Thanks Sebastian.

Do you want me to send a new revision with license changed to "GPL"?..or 
will you change it when it's merged?

Nandor
