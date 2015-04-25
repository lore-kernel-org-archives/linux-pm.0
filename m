From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] power_supply: Add support for Richtek rt9455 battery
 charger
Date: Sat, 25 Apr 2015 11:00:01 +0200
Message-ID: <1429952401.2927.91.camel@x220>
References: <1429862240-21619-1-git-send-email-anda-maria.nicolae@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429862240-21619-1-git-send-email-anda-maria.nicolae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
Cc: sre@kernel.org, dbaryshkov@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

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
