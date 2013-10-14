From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v3 04/14] ARM: mvebu: Remove the unused argument of
 set_cpu_coherent()
Date: Mon, 14 Oct 2013 16:23:58 +0200
Message-ID: <20131014162358.01e338bb@skate>
References: <1381759106-15004-1-git-send-email-gregory.clement@free-electrons.com>
	<1381759106-15004-5-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:32965 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750738Ab3JNOYC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Oct 2013 10:24:02 -0400
In-Reply-To: <1381759106-15004-5-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, lorenzo.pieralisi@arm.com, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, Lior Amsalem <alior@marvell.com>, Maen Suleiman <maen@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Eran Ben-Avi <benavi@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ike Pan <ike.pan@canonical.com>, Dan Frazier <dann.frazier@canonical.com>, Leif Lindholm <leif.lindholm@arm.com>, Jon Masters <jcm@redhat.com>, David Marlin <dmarlin@redhat.com>

Dear Gregory CLEMENT,

On Mon, 14 Oct 2013 15:58:16 +0200, Gregory CLEMENT wrote:
> set_cpu_coherent() took the SMP group ID as parameter. But this
> parameter was never used, and the CPU always use the SMP group 0. So

use -> uses

But probably better: "But this parameter was never used, and all CPUs
are always joining the SMP group 0".

Other than that:

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
