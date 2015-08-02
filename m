From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 5/6] power: bq27xxx_battery: Add support for
 additional bq27xxx family devices
Date: Sun, 2 Aug 2015 09:38:53 +0200
Message-ID: <20150802073853.GD3720@amd>
References: <1438112353-19704-1-git-send-email-afd@ti.com>
 <1438112353-19704-6-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47124 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbbHBHiz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 2 Aug 2015 03:38:55 -0400
Content-Disposition: inline
In-Reply-To: <1438112353-19704-6-git-send-email-afd@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


> +#define INVALID_REG_ADDR	0xff

> +static u8 bq27000_regs[] = {
> +	0x00,	/* CONTROL	*/
> +	0x06,	/* TEMP		*/
> +	0xff,	/* INT TEMP - NA*/

I'd use the INVALID_REG_ADDR macro here.. Makes it more clear what is
going on (and you may change it to -1 in future, for example).

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
