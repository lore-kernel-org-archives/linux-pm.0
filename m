From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 1/6] power: bq27x00_battery: Renaming for consistency
Date: Tue, 22 Sep 2015 18:07:35 -0700
Message-ID: <20150923010735.GD23801@atomide.com>
References: <1442950511-16122-1-git-send-email-afd@ti.com>
 <1442950511-16122-2-git-send-email-afd@ti.com>
 <20150922210028.GA15646@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:53458 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759787AbbIWBHk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 22 Sep 2015 21:07:40 -0400
Content-Disposition: inline
In-Reply-To: <20150922210028.GA15646@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>, "Andrew F. Davis" <afd@ti.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [150922 14:04]:
> Hi Tony and Guan,
> 
> I plan to merge the following patch, which changes
> CONFIG_BATTERY_BQ27x00 to CONFIG_BATTERY_BQ27xxx.
> This includes changes to omap2plus_defconfig and
> unicore32. Can you Ack this patch?

For omap2plus_defconfig:

Acked-by: Tony Lindgren <tony@atomide.com>
