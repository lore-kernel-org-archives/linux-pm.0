From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH] thermal: armada: read stable temp on Armada XP
Date: Wed, 25 Feb 2015 19:38:26 +0100
Message-ID: <54EE16A2.7020804@free-electrons.com>
References: <1423608615-6575-1-git-send-email-tylerwhall@gmail.com> <54EE009E.8070206@free-electrons.com> <54EE11C5.8000307@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54EE11C5.8000307@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tyler Hall <tylerwhall@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Ezequiel,

On 25/02/2015 19:17, Ezequiel Garcia wrote:
> On 02/25/2015 02:04 PM, Gregory CLEMENT wrote:
>>>
>>> My conclusions about these registers are based on experimental data. The
>>> documentation is very sparse, but the Thermal Manager Control and Status
>>> Register looks like the preferred register given the way it is laid out in the
>>> public spec.
>>
>> Ezequiel,
>>
>> as you worked on this do you know why we used the Thermal Sensor Status Register
>> instead of the Thermal Manager Control and Status Register ?
>> My first guess is that the giving the name of the registers the 1st one made
>> more sens to use for a thermal sensor.
>>
> 
> Actually, we based this driver in the vendor bootloader. The specs weren't
> of much use back then.
> 


Thanks for your prompt feedback. So we don't have much more information about
the sensor. :(

I will try to get information from Marvell.


Tyler,
In the meantime could you double check your values? The temperature on my board
seemed broken on my board. If needed I can check on an other board. By the way
on which board/product did you try it?


Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
