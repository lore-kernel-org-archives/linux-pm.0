From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 01/16] ARM: mvebu: Sort the headers of pmsu.c in alphabetic
 order
Date: Thu, 03 Jul 2014 00:57:54 +0200
Message-ID: <53B48E72.3050907@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>	<1403875377-940-2-git-send-email-gregory.clement@free-electrons.com> <20140630141630.684479f6@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:46676 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750920AbaGBW56 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jul 2014 18:57:58 -0400
In-Reply-To: <20140630141630.684479f6@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Hi Thomas,


>>  #include <linux/cpu_pm.h>
>> -#include <linux/kernel.h>
>>  #include <linux/init.h>
>> -#include <linux/of_address.h>
>> +#include <linux/kernel.h>
>>  #include <linux/io.h>
> 
> So, with your patch applied, if I'm correct, we will have:
> 
> #include <linux/init.h>
> #include <linux/kernel.h>
> #include <linux/io.h>
> 
> It seems like we're not yet alphabetically sorted here :)

Indeed, I will fix it


Thanks,

Gregory



-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
