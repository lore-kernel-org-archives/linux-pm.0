From: Laurentiu Palcu <lpalcu@gmail.com>
Subject: Re: [RFC] TI BQ242xx Battery Charger Development/Consolidation Plans
Date: Fri, 7 Aug 2015 11:58:17 +0300
Message-ID: <CAD03FC+DqSdg_LZ-SNaCNLsh9eZS9hSeJL5Q+8aWU+bGVcVPDQ@mail.gmail.com>
References: <1438706177-8115-1-git-send-email-dannenberg@ti.com>
	<55C23441.2030305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:34826 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbbHGI6T (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Aug 2015 04:58:19 -0400
Received: by lbbpo9 with SMTP id po9so57348895lbb.2
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2015 01:58:17 -0700 (PDT)
In-Reply-To: <55C23441.2030305@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Hi Andreas,

On 5 Aug 2015 19:11, "Andreas Dannenberg" <dannenberg@ti.com> wrote:
>
> Not too long I ago started working on a new driver called bq242xx_charger.c
> that will add support for TI's BQ24250, BQ24251, BQ24261M, and BQ24262 Li-Ion
> battery charger/power-path management ICs and that work is about 50% done. I
> chose a working name of bq242xx_charger.c in the hopes that in addition to
> providing immediate support for said devices that this driver can later be used
> as a platform to add other devices of the BQ242xx sub-family in an effort to
> re-use/consolidate and help keep drivers/power organized.
>
> Long story short I also realized that we just got a new bq24257_charger.c
> driver (for the BQ24257) already in the Linux 4.2 tree which creates somewhat
> of a conflict with the bq242xx_charger.c work in progress.
>
> I would like to solicit ideas/comments regarding the following plan of attack:
>
> - Continue bq242xx_charger.c development as scoped in the first paragraph
> - Work on getting it accepted into upstream
> - As future work, absorb the already existing bq24257_charger.c driver into the
>   bq242xx_charger.c driver, and deprecate its usage

Using wildcards in the driver name looks like a good idea until a new
part that fits the naming scheme appears but it's a totally different
product... Assuming those chips have a similar register layout as
BQ24257, why don't you start with the existing bq24257_charger driver
and build on that? Then, in Kconfig, make it clear what parts are
supported by the driver. This practice is quite common in Linux
kernel.

>
> There might be a potential risk for user confusion for a transitional time if
> somebody was just looking at the filenames to select their driver due to part
> number overlap. However I argue folks are more likely to go the Kconfig route
> to select their driver so this may not be a problem after all.

This one is tricky. If the BQ24257 chip became part of a commercial
product, then the customers will have to change the .config after
doing a kernel upgrade. Customers are not keen on doing that for a
commercially released product.

Sebastian, what do you think?

laurentiu
