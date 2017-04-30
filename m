From: "Alex A. Mihaylov" <minimumlaw@rambler.ru>
Subject: Re: [PATCH 1/2] Add support for OneWire (W1) devices family 0x26
 (MAX17211/MAX17215)
Date: Sun, 30 Apr 2017 08:21:51 +0300
Message-ID: <ee2edb43-2353-6655-a95d-ea3f3fb853eb@rambler.ru>
References: <20170429143429.5685-1-minimumlaw@rambler.ru>
 <20170429143429.5685-2-minimumlaw@rambler.ru>
 <20170429155911.7li5torcliaoerxh@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from huan3.mail.rambler.ru ([81.19.78.109]:28773 "EHLO
        huan3.mail.rambler.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1427027AbdD3FVy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Apr 2017 01:21:54 -0400
In-Reply-To: <20170429155911.7li5torcliaoerxh@earth>
Content-Language: ru
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, zbr@ioremap.net

Hi,


>> Slave device provide software layer for access to internal registers
>> MAX17211/MAX17215 chip.
> Please convert this to regmap.There is no generic w1 handler, but you can provide custom
> read/write functions.
I think regmap be overkill for this driver. Here we need access to a 
small number of registers.  Registers are extremely simple on the 
internal device. As a result, the software layer of regmap will only 
complicate the readability and understanding of the code. And also 
increase the size and time of code execution, and even complicate the 
perception.

> Also it would be nice to have this
> based on https://lkml.org/lkml/2017/3/16/604. Then everything
> could go into the power-supply driver.
>
No problems. Once this set of patches will be accepted in the mainline.

Alex.
