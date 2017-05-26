From: "Alex A. Mihaylov" <minimumlaw@rambler.ru>
Subject: Re: [PATCH 1/4] Introduce regmap infrastructure over Maxim/Dalas
 OneWire (W1) bus
Date: Fri, 26 May 2017 19:17:11 +0300
Message-ID: <86e846cd-95c2-621e-51ce-0da11f51b2c7@rambler.ru>
References: <20170525174639.3191-1-minimumlaw@rambler.ru>
 <20170525174639.3191-2-minimumlaw@rambler.ru>
 <404871495743279@web24o.yandex.ru>
 <20170526110602.jtvxf76abks4v3xf@sirena.org.uk>
 <3411811495806312@web49j.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from huan3.mail.rambler.ru ([81.19.78.109]:43848 "EHLO
        huan3.mail.rambler.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752407AbdEZQRO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 May 2017 12:17:14 -0400
In-Reply-To: <3411811495806312@web49j.yandex.ru>
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Evgeniy Polyakov <zbr@ioremap.net>, Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>


> Alex, it is up to you to decide whether you want to push your regmap version or not,
> I will not object against, but in my personal opinion your first version version was much cleaner.

I don't know. First edition (without regmap) was very simple. I think 
anyone could understand how this code works.

On the other hand, there is already a lot of duplicate code in the 
kernel, which is responsible for accessing device registers on the bus. 
In this sense, using the regmap infrastructure should help. As for the 
complex description of registers of a simple device, I consciously went 
into this complication by describing all the holes in the register map. 
Since this driver is a pioneer, he must use the maximum of 
infrastructure capabilities.

But I somehow do not really believe in the correctness of the 
realisation of regmap for W1. I have too few devices working with this 
bus. Theory, they all can work with my implementation of regmap. But not 
the fact that there will not be those who can not.
