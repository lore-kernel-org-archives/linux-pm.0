From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH 0/8] Add support for additional bq27xxx devices
Date: Thu, 23 Jul 2015 12:01:22 -0500
Message-ID: <55B11DE2.3030502@ti.com>
References: <1437601920-13045-1-git-send-email-afd@ti.com> <20150723162748.GJ29125@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47632 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752923AbbGWRCA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 23 Jul 2015 13:02:00 -0400
In-Reply-To: <20150723162748.GJ29125@pali>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>, "Andrew F. Davis" <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 07/23/2015 11:27 AM, Pali Roh=C3=A1r wrote:
> On Wednesday 22 July 2015 16:51:52 Andrew F. Davis wrote:

<snip>

> And I have another question for you: I see that there are now more
> bq24*_charger.c drivers for TI BQ charger chips. Do you think if it i=
s
> possible to do some cleanup & merge? Or all those charger chips
> different and every one should live in own kernel module?
=20
Pali,
on a related note I recently started working on a new driver named
bq242xx_charger.c that will add support for the following devices:

bq24250
bq24251
bq24261M
bq24262

These are TI's key devices in the bq2425x and bq2426x sub-families. I w=
as
actually also thinking about some larger consolidation but was
concerned about touching/breaking existing stuff and decided to do one
step at a time. And yes while there is some system-level overlap betwee=
n
most bq24xxx I'm also worried that providing good coverage of all
important device features for all different bq24xxx devices would yield
a very large and hard to understand driver.

As part of the bq242xx_charger.c development I'm keeping a close eye on
the existing bq24xxx drivers. If there seems an elegant way to do some
consolidation after all I might be able to broaden the scope of my work=
=2E

This being said I welcome additional ideas/suggestions here but for thi=
s
we should probably start a new thread.

Regards,

--=20
Andreas Dannenberg
Texas Instruments Inc.
