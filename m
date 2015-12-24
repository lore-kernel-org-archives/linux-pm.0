From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH 0/2] two fixes for new bq27000/10 and bq27500 driver
Date: Thu, 24 Dec 2015 07:57:56 -0600
Message-ID: <567BF9E4.20105@ti.com>
References: <cover.1450347172.git.hns@goldelico.com>
 <20151219080048.GA11317@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39738 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751503AbbLXN63 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 24 Dec 2015 08:58:29 -0500
In-Reply-To: <20151219080048.GA11317@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, gta04-owner@goldelico.com, marek@goldelico.com

On 12/19/2015 02:00 AM, Sebastian Reichel wrote:
> Hi Andrew,
>
> On Thu, Dec 17, 2015 at 11:12:52AM +0100, H. Nikolaus Schaller wrote:
>> H. Nikolaus Schaller (2):
>>    power:bq27xxx: fix reading for bq27000 and bq27010
>>    power:bq27xxx: fix register numbers of bq27500
>>
>>   drivers/power/bq27xxx_battery.c | 18 ++++++++++++------
>>   1 file changed, 12 insertions(+), 6 deletions(-)
>
> Can you give me your Acked-By (or Tested-By) for those patches?

Done

> Also I wonder if you would be available as official reviewer for
> the driver.

Sure, what's the normal procedure for this, should I submit a
patch adding myself to that driver in MAINTAINERS?
