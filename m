From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCHv4 1/1] thermal: intel Quark SoC X1000 DTS thermal driver
Date: Sat, 11 Apr 2015 12:04:11 +0200
Message-ID: <1428746651.17822.83.camel@x220>
References: <1428638821-9737-1-git-send-email-boon.leong.ong@intel.com>
	 <1428638821-9737-2-git-send-email-boon.leong.ong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lb2-smtp-cloud3.xs4all.net ([194.109.24.26]:59435 "EHLO
	lb2-smtp-cloud3.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752433AbbDKKEP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 11 Apr 2015 06:04:15 -0400
In-Reply-To: <1428638821-9737-2-git-send-email-boon.leong.ong@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ong Boon Leong <boon.leong.ong@intel.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, pure.logic@nexus-software.ie, hock.leong.kweh@intel.com, andy.shevchenko@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

There might be a mismatch between the license stated in the comment at
the top of the (only) source file of this driver and the license ident
used in the MODULE_LICENSE() macro.

On Fri, 2015-04-10 at 12:07 +0800, Ong Boon Leong wrote:
> --- /dev/null
> +++ b/drivers/thermal/intel_quark_dts_thermal.c

> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.

This only states the license is GPL v2.

> +MODULE_LICENSE("Dual BSD/GPL");

And this states that there's a "GNU Public License v2 or BSD license
choice". But if that's what you want, shouldn't the BSD license be
copied in that comment too? (Please note that this is not a rhetorical
question.)

Thanks,


Paul Bolle

