From: "Alex A. Mihaylov" <minimumlaw@rambler.ru>
Subject: Re: [PATCH 1/2] Add support for OneWire (W1) devices family 0x26
 (MAX17211/MAX17215)
Date: Mon, 1 May 2017 09:13:54 +0300
Message-ID: <f103ca48-1535-20ab-9384-f8dd34b7b57b@rambler.ru>
References: <20170429143429.5685-1-minimumlaw@rambler.ru>
 <20170429143429.5685-2-minimumlaw@rambler.ru>
 <20170429155911.7li5torcliaoerxh@earth>
 <ee2edb43-2353-6655-a95d-ea3f3fb853eb@rambler.ru>
 <20170430205337.kwuwcyesofvqjddl@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from huan2.mail.rambler.ru ([81.19.78.108]:41468 "EHLO
        huan2.mail.rambler.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2999578AbdEAGN5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 02:13:57 -0400
In-Reply-To: <20170430205337.kwuwcyesofvqjddl@earth>
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, zbr@ioremap.net

Hi!


30.04.17 23:53, Sebastian Reichel wrote::
>>>> Slave device provide software layer for access to internal registers
>>>> MAX17211/MAX17215 chip.
>>> Please convert this to regmap.There is no generic w1 handler, but you can provide custom
>>> read/write functions.
>> I think regmap be overkill for this driver. the perception.
> I did not ask for full usage of all regmap features. Just register
> the read/write handler as regmap handler and use regmap_read/write
> to get values.
>
OK, I think about this. But max17211-battery use ONLY 
w1_max12711x_reg_get(). This is very simple function.

Second function w1_max1721x_reg_set() writen for extend feature list 
(factory calibrating and init battery).  I think, this code must _NOT_ 
be writen, and must _NOT_ be accessible for end user. Change calibration 
values potentially can damage battery or device. Theory, I can unexport 
this function and remove them from drivers code.

So output registers of Maxim M5 Fuel Gauge algorithm very simple: one 
register - one value. In driver I have two points with bitfield. First - 
battery connected from power supply props. Second: very optional device 
type from probe. This value _NOT_ used from driver - just write device 
type, if manufacturer not fill this data in chip nvram.

This moment driver use 14 registers. Ok, let's some time above will be 
14*3=42 registers accessible with w1_max1721x_reg_get(). This value is 
greatly overestimated - so many properties are not in the class 
POWER_SUPPLY. But register range in MAX1721X is 0x1F0 (496 words or 992 
bytes) of RAM for cache registers. As embedded system developer I 
dislike so ram management.

As result I repeat: regmap will be overkill for this driver. But OK, I 
try to write this code. Just for fun.
