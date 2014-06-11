From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: mvebu: build error in -next
Date: Wed, 11 Jun 2014 14:07:40 +0200
Message-ID: <20140611140740.1bbe4a94@free-electrons.com>
References: <20140609185550.GA5034@arch.cereza>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:32811 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751510AbaFKMHz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Jun 2014 08:07:55 -0400
In-Reply-To: <20140609185550.GA5034@arch.cereza>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Gregory Clement <gregory.clement@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>

Dear Ezequiel Garcia,

On Mon, 9 Jun 2014 15:55:50 -0300, Ezequiel Garcia wrote:

> It seems we have a build error in latest -next (20140606):
> 
> arch/arm/mach-mvebu/built-in.o: In function `armada_370_xp_cpu_resume':
> /home/zeta/fast/linux/next/arch/arm/mach-mvebu/pmsu.c:145: undefined reference to `cpu_resume'
> arch/arm/mach-mvebu/built-in.o: In function `armada_370_xp_cpu_suspend':
> /home/zeta/fast/linux/next/arch/arm/mach-mvebu/pmsu.c:223: undefined reference to `cpu_suspend'
> 
> Find the config is enclosed; it's probably just a few ifdef's to add.

Thanks for reporting this, I've just sent a patch to fix it.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
