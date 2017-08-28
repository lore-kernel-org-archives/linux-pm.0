From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 5/5] power: bq24190_charger: Add
 power_supply_battery_info support
Date: Mon, 28 Aug 2017 09:02:16 -0700
Message-ID: <20170828160216.GE3930@atomide.com>
References: <20170826051413.24569-1-liam@networkimprov.net>
 <20170826051413.24569-6-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:38114 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751297AbdH1QCT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 28 Aug 2017 12:02:19 -0400
Content-Disposition: inline
In-Reply-To: <20170826051413.24569-6-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Liam Breck <kernel@networkimprov.net>

* Liam Breck <liam@networkimprov.net> [170825 22:15]:
> From: Liam Breck <kernel@networkimprov.net>
> 
> Set pre-charge and charge-term current, obtained from power_supply_battery_info.
> Add sysfs attributes precharge_current & charge_term_current.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>

Acked-by: Tony Lindgren <tony@atomide.com>
