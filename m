From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/7] power: supply: bq24190_charger: Use i2c-core
 irq-mapping code
Date: Wed, 22 Mar 2017 08:37:47 -0700
Message-ID: <20170322153747.GT8575@atomide.com>
References: <20170322145536.30570-1-hdegoede@redhat.com>
 <20170322145536.30570-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:41148 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934968AbdCVPiN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Mar 2017 11:38:13 -0400
Content-Disposition: inline
In-Reply-To: <20170322145536.30570-2-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

* Hans de Goede <hdegoede@redhat.com> [170322 07:57]:
> The i2c-core already maps of irqs before calling the driver's probe
> function and there are no in tree users of
> bq24190_platform_data->gpio_int.
> 
> Remove the redundant custom irq-mapping code and just use client->irq.

Looks right to me:

Acked-by: Tony Lindgren <tony@atomide.com>
