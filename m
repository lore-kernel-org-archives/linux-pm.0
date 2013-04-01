From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspended DRAM bridge
Date: Mon, 01 Apr 2013 22:56:34 +0200
Message-ID: <35938665.ZFvDxnCU3l@vostro.rjw.lan>
References: <5159BAC9.80700@fold.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:49605 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757445Ab3DAUtA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 1 Apr 2013 16:49:00 -0400
In-Reply-To: <5159BAC9.80700@fold.natur.cuni.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: Linux PM list <linux-pm@vger.kernel.org>

On Monday, April 01, 2013 06:50:17 PM Martin Mokrejs wrote:
> Hi Rafael,
>   I have a simple question. Why seems my DRAM controller suspended?

I suppose that runtime PM is disabled for that device and therefore
runtime_status is meaningless.

And really, that attribute is for *debugging* things by developers who know
what they are looking for and not for random poking.

Besides, this is a host bridge, not a DRAM controller.

> Does it make any sense in a laptop computer? How could the laptop work at all?

I suppose it wouldn't work if the PCI host bridge were suspended.  At least
it couldn't access memory and the PCI bus then.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
