From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH v1.1] ARM: multi_v7_defconfig: Enable power sequence for
 Odroid U3
Date: Mon, 9 Jan 2017 14:44:54 -0300
Message-ID: <953e4035-114d-6aa0-df88-8263b56be18b@osg.samsung.com>
References: <20170107085203.4431-5-krzk@kernel.org>
 <20170107091651.10560-1-krzk@kernel.org>
 <d8ee24b1-9d6b-e76f-b5ef-71706efbf9e5@osg.samsung.com>
 <CAJKOXPdODg2gCXP-BCRhDZAc2+o1J7Ek9iLaYF7hn_R2mNiK3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPdODg2gCXP-BCRhDZAc2+o1J7Ek9iLaYF7hn_R2mNiK3A@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Anand Moon <linux.amoon@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Peter Chen <peter.chen@nxp.com>, gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, hverkuil@xs4all.nl, Markus Reichl <m.reichl@fivetechno.de>
List-Id: linux-pm@vger.kernel.org

Hello Krzysztof,

On 01/09/2017 02:38 PM, Krzysztof Kozlowski wrote:
> On Mon, Jan 9, 2017 at 6:24 PM, Javier Martinez Canillas
> <javier@osg.samsung.com> wrote:
>> Hello Krzysztof,
>>
>> I think it would had been clearer if the subject prefix was "[PATCH v1.1 4/4]" :)
> 
> Ah, yes.
> 
>>
>> On 01/07/2017 06:16 AM, Krzysztof Kozlowski wrote:
>>> Odroid U3 needs a power sequence for lan9730, if it was enabled by
>>> bootloader.  Also enable the USB3503 HSCI to USB2.0 driver (device
>>> is present on Odroid U3).
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>>
>>> ---
>>>
>>
>> Do you think that makes sense to also enable GPIO_SYS for debugging
>> purposes as you do in patch 3/4?
> 
> I like the GPIO_SYSFS interface because it is easy to use. However
> now, after your question, I found this:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-November/470154.html
> ARM/ARM64: defconfig: drop GPIO_SYSFS on multiplatforms
> 
> ... so instead I will drop it from exynos_defconfig.
> 

Right, I forgot that using the GPIO sysfs interface is discouraged now and the
new chardev/ioctl based should be used instead. So it makes sense to drop it.

> Best regards,
> Krzysztof

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
