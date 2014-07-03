From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 05/16] ARM: mvebu: Add workaround for cpuidle support
 for Armada 370
Date: Thu, 03 Jul 2014 10:44:34 +0200
Message-ID: <53B517F2.4030104@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>	<1403875377-940-6-git-send-email-gregory.clement@free-electrons.com> <20140630145027.3b583cfa@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:48750 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964867AbaGCIoi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jul 2014 04:44:38 -0400
In-Reply-To: <20140630145027.3b583cfa@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Hi Thomas,

On 30/06/2014 14:50, Thomas Petazzoni wrote:
> Dear Gregory CLEMENT,
> 
> On Fri, 27 Jun 2014 15:22:46 +0200, Gregory CLEMENT wrote:
>> On Armada 370, there is "a slow exit process from the deep idle state
>> due to heavy L1/L2 cache cleanup operations performed by the BootROM
>> software" (cf errata GL-BootROM-10). To avoid this, we replace the
>> restart code of the BootROM by a simple jump to the boot address. Then
>> the code located at this boot address will take care of the
>> initialization.
>>
>> For this purpose, we use the common function mvebu_boot_addr_wa()
>> introduced in the previous commit.
> 
> "in the previous commit" would make sense if the commit immediately
> before this one in the series was the one you would be referencing. But
> that's not the case here, so it should be either: "introduced in one of
> the previous commits", or better "introduced in commit <title of the
> commit>".

Yes it should have been the previous commit at a point of development
and it was moved during a rebase. Using the title of the commit is more
reliable indeed.

> 
>>  #define PMSU_BASE_OFFSET    0x100
>>  #define PMSU_REG_SIZE	    0x1000
>> @@ -77,6 +76,9 @@ extern void ll_enable_coherency(void);
>>  
>>  extern void armada_370_xp_cpu_resume(void);
>>  
>> +static unsigned long pmsu_mp_phys_base;
> 
> phys_addr_t.

OK


Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
