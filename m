From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/5] power: bq24190_charger: Add ti,bq24192i to
 devicetree table
Date: Fri, 25 Aug 2017 13:28:16 -0700
Message-ID: <20170825202815.GT3930@atomide.com>
References: <20170807195420.20767-1-liam@networkimprov.net>
 <20170807195420.20767-2-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:37816 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758576AbdHYU2T (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 25 Aug 2017 16:28:19 -0400
Content-Disposition: inline
In-Reply-To: <20170807195420.20767-2-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Liam Breck <kernel@networkimprov.net>

* Liam Breck <liam@networkimprov.net> [170807 12:55]:
> From: Liam Breck <kernel@networkimprov.net>
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
>  #else
> -static const struct of_device_id bq24190_of_match[] = {
> -	{ },
> -};
> +static const struct of_device_id bq24190_of_match[] = { {} };
>  #endif

Maybe check what checkpatch says about this one?
It might actually prefer what we have now. You should
also mention it in the commit message or just drop that
change as people could complain it's an unrelated
change.

Regards,

Tony
