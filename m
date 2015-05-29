From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for May 29 (drivers/power/twl4030_charger)
Date: Fri, 29 May 2015 09:55:27 -0700
Message-ID: <556899FF.1040705@infradead.org>
References: <20150529221804.2b8940f3@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:41417 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756347AbbE2Qz2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 29 May 2015 12:55:28 -0400
In-Reply-To: <20150529221804.2b8940f3@canb.auug.org.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ignotas <notasas@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>

On 05/29/15 05:18, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20150528:
> 

on i386:
when CONFIG_USB_SUPPORT is not enabled:

../drivers/power/twl4030_charger.c: In function 'twl4030_bci_probe':
../drivers/power/twl4030_charger.c:648:4: error: implicit declaration of function 'devm_usb_get_phy_by_node' [-Werror=implicit-function-declaration]
    bci->transceiver = devm_usb_get_phy_by_node(
    ^
../drivers/power/twl4030_charger.c:648:21: warning: assignment makes pointer from integer without a cast [enabled by default]
    bci->transceiver = devm_usb_get_phy_by_node(
                     ^

Should this driver depend on USB_SUPPORT?


-- 
~Randy
