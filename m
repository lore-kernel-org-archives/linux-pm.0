From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 15/16] ARM: mvebu: Add CPU idle support for Armada 38x
Date: Thu, 03 Jul 2014 17:09:55 +0200
Message-ID: <53B57243.80300@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>	<1403875377-940-16-git-send-email-gregory.clement@free-electrons.com> <20140701163524.086a5f79@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:52447 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759010AbaGCPKA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jul 2014 11:10:00 -0400
In-Reply-To: <20140701163524.086a5f79@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Hi Thomas,

> On Fri, 27 Jun 2014 15:22:56 +0200, Gregory CLEMENT wrote:
> 
>> +ENTRY(armada_38x_cpu_resume)
>> +	/* do we need it for Armada 38x*/
>> +ARM_BE8(setend	be )			@ go BE8 if entered LE
> 
> We logically needed this, but I've confirmed, and indeed it is really
> needed for cpuidle to work properly on Armada 38x in big-endian
> configuration.
> 

OK
Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
