From: Josh Wu <josh.wu@atmel.com>
Subject: Re: [PATCH 1/2] power: reset: at91: add sama5d3 reset function
Date: Fri, 10 Jul 2015 11:52:39 +0800
Message-ID: <559F4187.8090803@atmel.com>
References: <1436436947-11210-1-git-send-email-josh.wu@atmel.com> <20150709173747.GA32448@roeck-us.net> <559F2719.3060708@atmel.com> <20150710031438.GA27089@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:37022 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473AbbGJDwq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2015 23:52:46 -0400
In-Reply-To: <20150710031438.GA27089@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Fabian Frederick <fabf@skynet.be>, linux-pm@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>

Hi, Guenter

On 7/10/2015 11:14 AM, Guenter Roeck wrote:
> On Fri, Jul 10, 2015 at 09:59:53AM +0800, Josh Wu wrote:
>> Hi, Guenter
>>
>> On 7/10/2015 1:37 AM, Guenter Roeck wrote:
>>> On Thu, Jul 09, 2015 at 06:15:46PM +0800, Josh Wu wrote:
>>>> As since sama5d3, to reset the chip, we don't need to shutdown the ddr
>>>> controller.
>>>>
>>>> So add a new compatible string and new restart function for sama5d3 and
>>>> later chips. As we don't use sama5d3 ddr controller, so remove it as
>>>> well.
>>>>
>>> That sounds like it should be two separate patches, or am I missing something ?
>> I think using one patch makes more sense. Maybe the commit log is not clear
>> enough. How about put it this way:
>>
>> This patch introduces a new compatible string: "atmel,sama5d3-rstc" for the
>> reset driver of sama5d3 and later chips.
>> As in sama5d3 or later chips, we don't have to shutdown the DDR controller
>> before reset. Shutdown the DDR controller before reset is a workaround to
>> avoid DDR signal driving the bus, but since sama5d3 and later chips there is
>> no such a conflict.
>> That means:
>>    1. the sama5d3 reset function only need to write the rstc register and
>> return.
>>    2. for sama5d3, we can remove the code related with DDR controller as we
>> don't use it at all.
>>
> Sorry, I don't get it. Doesn't that mean there are two distinct logical
> changes, which would ask for two separate patches ?

The rewritten reset function for sama5d3 has no need to access the ddr 
controller, so this patch rewrite the reset function and remove ddr 
access for sama5d3.
Those two changes are related and so make it as one patch is reasonable.

Best Regards,
Josh Wu
>
> Guenter

