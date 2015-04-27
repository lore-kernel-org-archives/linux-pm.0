From: "Nicolae, Anda-maria" <anda-maria.nicolae@intel.com>
Subject: RE: [PATCH] power_supply: Add support for Richtek rt9455 battery
 charger
Date: Mon, 27 Apr 2015 13:00:11 +0000
Message-ID: <11982715D62E664DBACA4351A418B0581437DA44@IRSMSX107.ger.corp.intel.com>
References: <1429862240-21619-1-git-send-email-anda-maria.nicolae@intel.com>,<1429952401.2927.91.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:49644 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752967AbbD0NAQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2015 09:00:16 -0400
In-Reply-To: <1429952401.2927.91.camel@x220>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: "sre@kernel.org" <sre@kernel.org>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hello Paul,

Thanks for feedback :). 
I understand. I will change the license to GPL.

Thanks,
Anda

________________________________________
From: Paul Bolle [pebolle@tiscali.nl]
Sent: Saturday, April 25, 2015 12:00 PM
To: Nicolae, Anda-maria
Cc: sre@kernel.org; dbaryshkov@gmail.com; robh+dt@kernel.org; pawel.moll@arm.com; mark.rutland@arm.com; ijc+devicetree@hellion.org.uk; galak@codeaurora.org; dwmw2@infradead.org; linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
Subject: Re: [PATCH] power_supply: Add support for Richtek rt9455 battery charger

Just a single nit: a license mismatch.

On Fri, 2015-04-24 at 10:57 +0300, Anda-Maria Nicolae wrote:
> --- /dev/null
> +++ b/drivers/power/rt9455_charger.c

> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

This states the license is GPL v2 or later.

> +MODULE_LICENSE("GPL v2");

And, according to include/linux/module.h, this states the license is
(only) GPL v2. So I think either the license comment or the ident used
in the MODULE_LICENSE() macro should be changed.


Paul Bolle

