From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 3/7] power: supply: bq24190_charger: Use extcon to
 determine ilimit, 5v boost
Date: Wed, 22 Mar 2017 08:50:29 -0700
Message-ID: <20170322155029.GX8575@atomide.com>
References: <20170322145536.30570-1-hdegoede@redhat.com>
 <20170322145536.30570-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:41214 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964909AbdCVPux (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Mar 2017 11:50:53 -0400
Content-Disposition: inline
In-Reply-To: <20170322145536.30570-4-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

* Hans de Goede <hdegoede@redhat.com> [170322 07:57]:
> Add support for monitoring an extcon device with USB SDP/CDP/DCP and HOST
> cables and adjust ilimit and enable/disable the 5V boost converter
> accordingly. This is necessary on systems where the PSEL pin is hardwired
> high and ILIM needs to be set by software based on the detected charger
> type, as well as on systems where the 5V boost converter is used, as
> that always needs to be enabled from software.

I wonder if these cross device and cross subsystem events really should
be handled at the framework level? Otherwise the permutations get out
of control fast..

Regards,

Tony
