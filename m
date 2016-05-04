From: Manish Badarkhe <badarkhe.manish@gmail.com>
Subject: Re: [RESEND PATCH v10 4/4] power: wm831x_power: Support USB charger
 current limit management
Date: Wed, 4 May 2016 08:59:23 +0530
Message-ID: <CAKDJKT4=LtMRGJKnj6CkYhey1Avmdk0gFf-mTQuDz+VrRrQsMg@mail.gmail.com>
References: <cover.1462245638.git.baolin.wang@linaro.org>
	<80aa73ffd5c8e9ae8cd280d37f5141067e79c11f.1462245638.git.baolin.wang@linaro.org>
	<CAKDJKT46cJQbjdObUxBpWsciG1FjcL8CdV7iAeMefjNQPGicKA@mail.gmail.com>
	<20160503105718.GL6292@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:33344 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458AbcEDD3Y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 May 2016 23:29:24 -0400
In-Reply-To: <20160503105718.GL6292@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, peter.chen@freescale.com, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, Lee Jones <lee.jones@linaro.org>, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Mark

>> > +static const unsigned int wm831x_usb_limits[] = {
>> > +       0,
>> > +       2,
>> > +       100,
>> > +       500,
>> > +       900,
>> > +       1500,
>> > +       1800,
>> > +       550,
>> > +};
>
>> Just for curiosity, How these current limits are getting decided?
>> Can we have some proper defines over here so that it can be grasped easily?
>
> They're in the silicon, it's just a table of values that were put into
> the silicon at design time.  The defines would just be TABLE_ENTRY_1 or
> whatever.

Thanks for the clarification, In that case, comments/documentation
will work instead of making any defines.

Regards
Manish Badarkhe
