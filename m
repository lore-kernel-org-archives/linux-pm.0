From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 3/5] power: bq24190_charger: Enable devicetree config
Date: Mon, 28 Aug 2017 14:27:09 -0700
Message-ID: <20170828212707.GH3930@atomide.com>
References: <20170828212349.19037-1-liam@networkimprov.net>
 <20170828212349.19037-4-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:38290 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751218AbdH1V1L (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 28 Aug 2017 17:27:11 -0400
Content-Disposition: inline
In-Reply-To: <20170828212349.19037-4-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Liam Breck <kernel@networkimprov.net>

* Liam Breck <liam@networkimprov.net> [170828 14:24]:
> From: Liam Breck <kernel@networkimprov.net>
> 
> Add get_config(). Rename set_mode_host() to set_config().
> Call get_config() and hw_init() after power_supply_register().
> No functional changes.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>

Acked-by: Tony Lindgren <tony@atomide.com>
