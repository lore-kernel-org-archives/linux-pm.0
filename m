From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 5/7] power: supply: bq24190_charger: Don't spam the
 logs on charger plug / unplug
Date: Wed, 22 Mar 2017 08:44:26 -0700
Message-ID: <20170322154425.GV8575@atomide.com>
References: <20170322145536.30570-1-hdegoede@redhat.com>
 <20170322145536.30570-6-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:41174 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759063AbdCVPp4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Mar 2017 11:45:56 -0400
Content-Disposition: inline
In-Reply-To: <20170322145536.30570-6-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

* Hans de Goede <hdegoede@redhat.com> [170322 07:57]:
> If the charger gets unplugged before the battery is fully charged we will
> get a one time Input fault. Ignore this rather then logging a message for
> it. Likewise on the next interrupt after the one time Input fault all
> fault flags will be 0, do not log a message when there are no faults.
> 
> This fixes messages like these getting logged on charger unplug + replug:
> bq24190-charger 15-006b: Fault: boost 0, charge 1, battery 0, ntc 0
> bq24190-charger 15-006b: Fault: boost 0, charge 0, battery 0, ntc 0

Acked-by: Tony Lindgren <tony@atomide.com>
