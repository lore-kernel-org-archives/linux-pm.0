From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 03/16] ARM: mvebu: Add function to export the physical
 address of the boot register
Date: Tue, 1 Jul 2014 13:46:51 +0200
Message-ID: <20140701134651.7d34de62@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
	<1403875377-940-4-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:34432 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751124AbaGALqz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Jul 2014 07:46:55 -0400
In-Reply-To: <1403875377-940-4-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Dear Gregory CLEMENT,

On Fri, 27 Jun 2014 15:22:44 +0200, Gregory CLEMENT wrote:

>  static void __iomem *system_controller_base;
> +static u32 system_controller_phys_base;
>  
>  struct mvebu_system_controller {
>  	u32 rstoutn_mask_offset;
> @@ -109,6 +110,13 @@ void mvebu_system_controller_set_cpu_boot_addr(void *boot_addr)
>  	writel(virt_to_phys(boot_addr), system_controller_base +
>  	       mvebu_sc->resume_boot_addr);
>  }
> +
> +u32 mvebu_system_controller_get_phys_addr(void)
> +{
> +	BUG_ON(system_controller_phys_base == NULL);

This rightfully generates a fairly strong warning at compile time:
you're comparing an u32 to NULL. It should be == 0 here.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
