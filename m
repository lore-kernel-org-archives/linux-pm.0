From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v3 05/14] ARM: mvebu: Make ll_set_cpu_coherent() more
 configurable
Date: Mon, 14 Oct 2013 16:26:36 +0200
Message-ID: <20131014162636.1f486053@skate>
References: <1381759106-15004-1-git-send-email-gregory.clement@free-electrons.com>
	<1381759106-15004-6-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:33007 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754084Ab3JNO0j (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Oct 2013 10:26:39 -0400
In-Reply-To: <1381759106-15004-6-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, lorenzo.pieralisi@arm.com, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, Lior Amsalem <alior@marvell.com>, Maen Suleiman <maen@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Eran Ben-Avi <benavi@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ike Pan <ike.pan@canonical.com>, Dan Frazier <dann.frazier@canonical.com>, Leif Lindholm <leif.lindholm@arm.com>, Jon Masters <jcm@redhat.com>, David Marlin <dmarlin@redhat.com>

Dear Gregory CLEMENT,

On Mon, 14 Oct 2013 15:58:17 +0200, Gregory CLEMENT wrote:
> ll_set_cpu_coherent does two things to set the coherency for a CPU:
> 
> - Adding the CPU to the SMP group 0
> - Enabling the snooping on the CPU
> 
> Only the second part is needed when coming back from a CPU Idle. This
> commit allows to choose to do the first part or not.

I am not a fan of this change: those two boolean arguments are really
mystical. If a function does do things, and sometimes must be called to
do one thing, and sometimes for two things, it is really calling for a
split of the functions (with potentially the second function calling the
first, or the two functions being called in a row when needed).

Let's have two functions:

	ll_set_cpu_smp_group();
	ll_set_cpu_coherent();

at initialization time, both functions are called. On the exit path of
idle, only the second one is called.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
