From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v4 03/13] ARM: mvebu: ll_set_cpu_coherent always uses
 the current CPU
Date: Wed, 19 Feb 2014 17:09:07 +0100
Message-ID: <20140219170907.002941da@skate>
References: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>
	<1392312816-17657-4-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:50463 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753801AbaBSQK0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Feb 2014 11:10:26 -0500
In-Reply-To: <1392312816-17657-4-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Dear Gregory CLEMENT,

On Thu, 13 Feb 2014 18:33:26 +0100, Gregory CLEMENT wrote:
> ll_set_cpu_coherent is always used on the current CPU, so instead of
> passing the CPU id as argument, ll_set_cpu_coherent() can find it by
> itself.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/coherency.c    | 10 +++++-----
>  arch/arm/mach-mvebu/coherency.h    |  2 +-
>  arch/arm/mach-mvebu/coherency_ll.S | 12 ++++++------
>  arch/arm/mach-mvebu/headsmp.S      |  4 ----
>  arch/arm/mach-mvebu/platsmp.c      |  2 +-
>  5 files changed, 13 insertions(+), 17 deletions(-)

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

with just one thing I am not entirely sure about:

>  	/* Create bit by cpu index */
> -	mov	r3, #(1 << 24)
> -	lsl	r1, r3, r1
> -ARM_BE8(rev	r1, r1)
> +	mrc	15, 0, r1, cr0, cr0, 5
> +	and	r1, r1, #15
> +	mov	r2, #(1 << 24)
> +	lsl	r1, r2, r1
> +	ARM_BE8(rev	r1, r1)

Have you tested this in a big endian configuration? I'd like to make
sure we have gotten the ARM_BE8(rev ...) thing correct.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
