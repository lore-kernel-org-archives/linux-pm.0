From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Oct 21 (regmap-spmi.c caused by
 QCOM_SPMI_TEMP_ALARM)
Date: Wed, 21 Oct 2015 13:54:22 -0700
Message-ID: <5627FB7E.60300@infradead.org>
References: <20151021171623.2d651735@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:34509 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158AbbJUUyX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 Oct 2015 16:54:23 -0400
In-Reply-To: <20151021171623.2d651735@canb.auug.org.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>

On 10/20/15 23:16, Stephen Rothwell wrote:
> Hi all,
> 
> There will be no linux-next releases after tomorrow until Nov 2 (kernel
> summit).
> 
> Changes since 20151020:
> 

on x86_64:

warning: (QCOM_SPMI_TEMP_ALARM) selects REGMAP_SPMI which has unmet direct dependencies (SPMI)

drivers/built-in.o: In function `regmap_spmi_base_read':
regmap-spmi.c:(.text+0x1bef59): undefined reference to `spmi_register_read'
drivers/built-in.o: In function `regmap_spmi_base_gather_write':
regmap-spmi.c:(.text+0x1befd3): undefined reference to `spmi_register_zero_write'
regmap-spmi.c:(.text+0x1bf007): undefined reference to `spmi_register_write'
drivers/built-in.o: In function `regmap_spmi_ext_read':
regmap-spmi.c:(.text+0x1bf106): undefined reference to `spmi_ext_register_read'
regmap-spmi.c:(.text+0x1bf14d): undefined reference to `spmi_ext_register_readl'
drivers/built-in.o: In function `regmap_spmi_ext_gather_write':
regmap-spmi.c:(.text+0x1bf1f6): undefined reference to `spmi_ext_register_write'
regmap-spmi.c:(.text+0x1bf23d): undefined reference to `spmi_ext_register_writel'



CONFIG_REGMAP_SPMI=y
CONFIG_SPMI is not enabled.
CONFIG_QCOM_SPMI_TEMP_ALARM=y
CONFIG_COMPILE_TEST=y



-- 
~Randy
