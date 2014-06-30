From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 07/16] ARM: mvebu: Make the CPU idle initialization more
 generic
Date: Mon, 30 Jun 2014 12:30:50 +0200
Message-ID: <53B13C5A.80603@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com> <1403875377-940-8-git-send-email-gregory.clement@free-electrons.com> <53AD7C90.6080600@free-electrons.com> <20140628145625.GL23978@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:53193 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753740AbaF3Kft (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Jun 2014 06:35:49 -0400
In-Reply-To: <20140628145625.GL23978@titan.lakedaemon.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

Hi Jason,


>>> +	np = of_find_matching_node_and_match(NULL, of_cpuidle_table,
>>> +					&match);
>>> +
>>
>> The following part was missing (without this the kernel hang on Armada 375)
>>
>> +       if (!np)
>> +               return 0;
> 
> If there's no other changes, I can fix this up when I apply it.  As well
> as the S-o-b.


Thanks. Let's hope it will be the case, and there will no need to a
new version of this series. :)

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
