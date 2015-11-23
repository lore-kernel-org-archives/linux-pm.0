From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] power: bq27xxx_battery: Reorganize I2C into a module
Date: Mon, 23 Nov 2015 17:57:28 +0100
Message-ID: <3809374.hKy9fQ2ldj@wuerfel>
References: <1448297631-8916-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:50807 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbbKWQ6J (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2015 11:58:09 -0500
In-Reply-To: <1448297631-8916-1-git-send-email-afd@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Andreas Dannenberg <dannenberg@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 23 November 2015 10:53:51 Andrew F. Davis wrote:
> Separate out I2C functionality into a module. This fixes several small
> issues and simplifies the driver initialization.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>

That looks good to me overall, it should help with the randconfig
warnings I've been seeing and makes the driver structured more logically.

The one part I wonder about is whether the platform_driver portion
should also be split out into a separate module in the same way.

	Arnd
