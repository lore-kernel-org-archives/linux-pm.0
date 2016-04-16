From: Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] PM / clk: ensure we don't allocate a -ve size of count
 clks
Date: Sat, 16 Apr 2016 14:49:40 +0100
Message-ID: <571242F4.5080103@canonical.com>
References: <1460811003-31806-1-git-send-email-colin.king@canonical.com>
 <20160416125235.GB31772@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:41825 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbcDPNto (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 16 Apr 2016 09:49:44 -0400
In-Reply-To: <20160416125235.GB31772@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 16/04/16 13:52, Pavel Machek wrote:
> On Sat 2016-04-16 13:50:03, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> It is entirely possible for of_count_phandle_wit_args to
>> return a -ve error return value so we need to check for this
>> otherwise we end up allocating a negative number of clk objects.
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> 
>> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
>> index 0e64a1b..3657ac1 100644
>> --- a/drivers/base/power/clock_ops.c
>> +++ b/drivers/base/power/clock_ops.c
>> @@ -159,7 +159,7 @@ int of_pm_clk_add_clks(struct device *dev)
>>  
>>  	count = of_count_phandle_with_args(dev->of_node, "clocks",
>>  					   "#clock-cells");
>> -	if (count == 0)
>> +	if (count <= 0)
>>  		return -ENODEV;
> 
> Would it make sense to propagate the error value?

I don't think it will contribute much more than the current return.

> 
> 									Pavel
> 

