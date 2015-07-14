From: Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH] power: Destroy IDRs on module exit
Date: Tue, 14 Jul 2015 12:48:31 +0200
Message-ID: <mqd1tgb816o.fsf@c203.arch.suse.de>
References: <1436865374-22027-1-git-send-email-jthumshirn@suse.de>
	<20150714101948.GA17240@earth>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48571 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752840AbbGNKsh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 14 Jul 2015 06:48:37 -0400
In-Reply-To: <20150714101948.GA17240@earth> (Sebastian Reichel's message of
	"Tue, 14 Jul 2015 12:19:48 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Pali =?utf-8?Q?Roh=C3=A1r?= <pali.rohar@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Johannes Thumshirn <jthumshirn@suse.de>

Sebastian Reichel <sre@kernel.org> writes:

> [+CC: Tejun Heo <tj@kernel.org>, for being very active in lib/idr.c]
>
> Hi,
>
> On Tue, Jul 14, 2015 at 11:16:14AM +0200, Johannes Thumshirn wrote:
>> Destroy IDRs on module exit, freeing the resources for
>> * bq2415x_charger.c
>> * ds2782_battery.c
>> * ltc2941-battery-gauge.c
>
> You missed bq27x00_battery.c. Maybe a coccinelle script should be
> written?

I already did this one that last week (I think), it should've been in
your INBOX (I hope).

>> The drivers had to be converted to "ordinary" module_init()/module_exit()
>> style drivers instead of using module_i2c_driver.
>
> mh I would prefer another solution. How about adding something
> like this:
>
> static void idr_remove_and_destroy(struct idr *idp, int id)
> {
>     idr_remove(idp, id);
>     if (idr_is_empty(idp)
>         idr_destroy(idp);
> }
>
> If that is called by the drivers instead of idr_remove(), there
> should be no need for adding idr_destroy to module_exit().
>

This would be an option.

[Copied a part of Palin's reply in here as well]
Palin> I'm feeling that there is something wrong with idr API. There is no idr
Palin> code in __init functions, so why it is needed for __exit? idr functions
Palin> are used in devices, not in global module.

but I start getting a bit puzzled about the whole IDR thing. Further
grepping through the tree revealed even more drivers doing
DEFINE_ID{A,R} but not all doing the destroy calls afterwards. Maybe
Tejun can clarify on this.

Johannes
