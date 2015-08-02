From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v2 5/6] power: bq27xxx_battery: Add support for additional
 bq27xxx family devices
Date: Sun, 2 Aug 2015 12:43:17 -0500
Message-ID: <55BE56B5.6040608@ti.com>
References: <1438112353-19704-1-git-send-email-afd@ti.com> <1438112353-19704-6-git-send-email-afd@ti.com> <20150802073853.GD3720@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37445 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750972AbbHBRnr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 2 Aug 2015 13:43:47 -0400
In-Reply-To: <20150802073853.GD3720@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: =?windows-1252?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 08/02/2015 02:38 AM, Pavel Machek wrote:
>
>> +#define INVALID_REG_ADDR	0xff
>
>> +static u8 bq27000_regs[] = {
>> +	0x00,	/* CONTROL	*/
>> +	0x06,	/* TEMP		*/
>> +	0xff,	/* INT TEMP - NA*/
>
> I'd use the INVALID_REG_ADDR macro here.. Makes it more clear what is
> going on (and you may change it to -1 in future, for example).
>

That works, I'll do that.

Thanks,
-- 
Andrew F. Davis
