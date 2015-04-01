From: Beomho Seo <beomho.seo@samsung.com>
Subject: Re: [PATCH 1/3] power: max17042_battery: Use reg type instead of chip
 type
Date: Wed, 01 Apr 2015 09:03:14 +0900
Message-ID: <551B35C2.6070207@samsung.com>
References: <1427808847-19498-1-git-send-email-beomho.seo@samsung.com>
 <1427808847-19498-2-git-send-email-beomho.seo@samsung.com>
 <20150331153155.GA25737@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:27127 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507AbbDAADs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2015 20:03:48 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NM300CYMPHF84B0@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 01 Apr 2015 09:03:15 +0900 (KST)
In-reply-to: <20150331153155.GA25737@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, =?UTF-8?B?J+uMgOyduOq4sCc=?= <inki.dae@samsung.com>

On 04/01/2015 12:31 AM, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Mar 31, 2015 at 10:34:05PM +0900, Beomho Seo wrote:
>> [...]
>>  	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
>> -		if (chip->chip_type == MAX17042)
>> +		if (chip->reg_type == MAXIM_REG_TYPE_MAX17047)
>>  			ret = regmap_read(map, MAX17042_V_empty, &data);
>>  		else
>>  			ret = regmap_read(map, MAX17047_V_empty, &data);
> 
> Looks like you inverted the logic.
> 
>> [...]
> 
> -- Sebastian
> 

OK I will fix it.
Thank you for comment.

Best regards,
Beomho Seo

