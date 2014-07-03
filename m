From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 09/16] ARM: mvebu: Make the snoop disable optional in
 mvebu_v7_pmsu_idle_prepare
Date: Thu, 03 Jul 2014 14:50:22 +0200
Message-ID: <53B5518E.3050702@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>	<1403875377-940-10-git-send-email-gregory.clement@free-electrons.com> <20140630174338.13604523@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:50106 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756736AbaGCMu2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jul 2014 08:50:28 -0400
In-Reply-To: <20140630174338.13604523@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Hi Thomas,

>>  /* No locking is needed because we only access per-CPU registers */
>> -static void mvebu_v7_pmsu_idle_prepare(bool deepidle)
>> +static void mvebu_v7_pmsu_idle_prepare(bool deepidle, bool snoopdis)
> 
> I continue to find it odd to have more and more boolean arguments to a
> function to indicate what the function should do. It often indicates
> that the function should rather be split in smaller, fine-grained
> functions. Another sad consequence of using booleans is that the call
> sites of the functions can no longer be understood properly:
> 
> 	mvebu_v7_pmsu_idle_prepare(false, true);
> 	mvebu_v7_pmsu_idle_prepare(true, true);
> 	mvebu_v7_pmsu_idle_prepare(false, false);
> 
> But oh well, it looks like it's the easiest solution here, and I admit
> it's convenient to have one function to the entire business of
> preparing for idle.

Maybe we can use flags, hence we use only one arguments, it became extensible,
and more readable too. Something like

#define PMSU_IDLE_NO_FLAG 0
#define PMSU_IDLE_DEEPIDLE BIT(0)
#define PMSU_IDLE_SNOOPDIS BIT(1)

then we can have:
mvebu_v7_pmsu_idle_prepare(PMSU_IDLE_SNOOPDIS);
mvebu_v7_pmsu_idle_prepare(PMSU_IDLE_DEEPIDLE | PMSU_IDLE_SNOOPDIS);
mvebu_v7_pmsu_idle_prepare(PMSU_IDLE_NO_FLAG);

static void mvebu_v7_pmsu_idle_prepare(u32 flags)

Thanks,

Gregory



-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
