From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 00/16] CPU Idle for Armada 370 and Armada 38x
Date: Mon, 30 Jun 2014 17:51:39 +0200
Message-ID: <53B1878B.9060701@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com> <20140630174520.194d4781@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:56222 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751184AbaF3Pvm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Jun 2014 11:51:42 -0400
In-Reply-To: <20140630174520.194d4781@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

On 30/06/2014 17:45, Thomas Petazzoni wrote:
> Gregory,
> 
> On Fri, 27 Jun 2014 15:22:41 +0200, Gregory CLEMENT wrote:
> 
>> This patch set adds the CPU Idle support for two mvebu SoCs: the
>> Armada 370 and the Armada 38x. As there are common parts with the
>> current support of cpuidle of the Armada XP. I made the code even more
>> generic. Thanks to this change, adding a new SoC is now only done in
>> the architecture specific part and we won't have to touch the cpuidle
>> driver anymore for this.
> 
> I'd like to do some testing of this patch series, especially in big
> endian situations. Do you have a Git repository where this version was
> pushed?

Yes sure, the branch CPU-Idle-mvebu-next-3.16-rc2-V1 on
https://github.com/MISL-EBU-System-SW/mainline-public.git

> 
> Thanks,
> 
> Thomas
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
