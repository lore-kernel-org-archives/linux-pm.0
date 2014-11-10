From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] PM / Domains: Fix initial default state of the need_restore flag
Date: Mon, 10 Nov 2014 12:33:15 -0800
Message-ID: <F09FA55F-7246-4E9F-B54D-7CB984E10161@gmail.com>
References: <1415366847-4807-1-git-send-email-ulf.hansson@linaro.org> <7hr3xerdw6.fsf@deeprootsystems.com> <20141107215751.GA4439@dtor-ws> <CAPDyKFot-LZjazq190cY3-tawB_-ukdsmrLcD3vtidLvX68FOg@mail.gmail.com> <20141110183224.GA5626@dtor-ws> <20141110193931.GN3815@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:42814 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbaKJUdY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Nov 2014 15:33:24 -0500
In-Reply-To: <20141110193931.GN3815@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaro

On November 10, 2014 11:39:31 AM PST, Mark Brown <broonie@kernel.org> wrote:
>On Mon, Nov 10, 2014 at 10:32:24AM -0800, Dmitry Torokhov wrote:
>
>> - I do not see why sirincling platform specific code around i2c, spi,
>>   etc bus code (which is not platform-specific) is OK, but a no-no
>for
>>   the driver ocre.
>
>sirincling?

Sorry, I was going for "sprinkling" but failed spectacularly.


Thanks.

-- 
Dmitry
