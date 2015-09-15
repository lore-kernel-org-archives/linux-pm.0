From: Laurentiu Palcu <laurentiu.palcu@intel.com>
Subject: Re: [PATCH v4 2/7] power: bq27x00_battery: Renaming for consistency
Date: Tue, 15 Sep 2015 11:32:24 +0300
Message-ID: <20150915083224.GA3166@lpalcu-desk>
References: <1442265973-32261-1-git-send-email-afd@ti.com>
 <1442265973-32261-3-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41965 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751693AbbIOIca (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 15 Sep 2015 04:32:30 -0400
Content-Disposition: inline
In-Reply-To: <1442265973-32261-3-git-send-email-afd@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Sep 14, 2015 at 04:26:08PM -0500, Andrew F. Davis wrote:
> Rename functions that are used by multiple devices. New devices
> have been added and the function names and driver name are no longer
> general enough for the functionality they provide.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  MAINTAINERS                                        |   4 +-
>  arch/arm/configs/omap2plus_defconfig               |   2 +-
>  arch/unicore32/Kconfig                             |   2 +-
>  drivers/power/Kconfig                              |  22 +-
>  drivers/power/Makefile                             |   2 +-
>  .../power/{bq27x00_battery.c => bq27xxx_battery.c} | 333 +++++++++++----------

1000 chips! That's how many potential chips is this driver supposed to
support, after the rename, with little or no modifications. Is it even
possible to guarantee that all future chips, starting with 'bq27' in
their naming scheme, are register compatible?

Call me conservative, but when I see driver names/renames containing
wildcards, I get chills down my spine. I can probably get over single
digit wildcards but 3 digit wildcards is a little too much. :)

I can't help but wonder what will one have to do if one single newly
released bq27xxx chip is completely different... :/

laurentiu


