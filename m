From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Gta04-owner] [PATCH v2 0/3] Fixes for twl4030 charger
Date: Mon, 23 Nov 2015 10:27:42 +0100
Message-ID: <D216A49B-A475-494F-A65F-409EC6C6AE15@goldelico.com>
References: <cover.1446463652.git.hns@goldelico.com> <F2CD8FEF-DFE1-4A11-8000-7127CDEE63B7@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:50873 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbbKWJ1q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2015 04:27:46 -0500
In-Reply-To: <F2CD8FEF-DFE1-4A11-8000-7127CDEE63B7@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Andreas Kemnade <andreas@kemnade.info>, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, =?windows-1252?Q?Gra=9Evydas_Ignotas?= <notasas@gmail.com>

ping.

Am 13.11.2015 um 11:28 schrieb H. Nikolaus Schaller <hns@goldelico.com>:

> ping.
> 
> Am 02.11.2015 um 12:27 schrieb H. Nikolaus Schaller <hns@goldelico.com>:
> 
>> Changes V2:
>> * worked in comments by Nishanth Menon <nm@ti.com>
>> * added another patch which solves a probing/boot stall problem (irq allocation vs. -EPROBE_DEFER)
>> 
>> V1:
>> 4.3-rc1 introduced a new charger driver for the twl4030.
>> 
>> While making it operable and testing on GTA04 and OpenPandora
>> we have found some issues.
>> 
>> 
>> H. Nikolaus Schaller (3):
>> drivers:power:twl4030-charger: fix problem with EPROBE_DEFER
>> drivers:power:twl4030-charger: don't return after allocating irq
>> drivers:power:twl4030-charger: don't check if battery is present
>> 
>> drivers/power/twl4030_charger.c | 39 ++++++++++++++++++---------------------
>> 1 file changed, 18 insertions(+), 21 deletions(-)
>> 
>> -- 
>> 2.5.1
>> 
> 
> _______________________________________________
> Gta04-owner mailing list
> Gta04-owner@goldelico.com
> http://lists.goldelico.com/mailman/listinfo.cgi/gta04-owner

