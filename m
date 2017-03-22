From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v1 5/7] power: bq24190_charger: Reorder init sequence in
 probe()
Date: Wed, 22 Mar 2017 08:36:10 -0700
Message-ID: <20170322153610.GS8575@atomide.com>
References: <20170321220921.5834-1-liam@networkimprov.net>
 <20170321220921.5834-6-liam@networkimprov.net>
 <7d826cba-8d4a-4c09-0865-1c042edb552a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:41128 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934895AbdCVPgT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Mar 2017 11:36:19 -0400
Content-Disposition: inline
In-Reply-To: <7d826cba-8d4a-4c09-0865-1c042edb552a@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Liam Breck <liam@networkimprov.net>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Mark Greer <mgreer@animalcreek.com>, Liam Breck <kernel@networkimprov.net>

* Hans de Goede <hdegoede@redhat.com> [170322 05:16]:
> Hi,
> 
> On 21-03-17 23:09, Liam Breck wrote:
> > From: Liam Breck <kernel@networkimprov.net>
> > 
> > We need a struct power_supply object from register() before
> > calling setup_dt()
> > 
> > Cc: Mark Greer <mgreer@animalcreek.com>
> > Signed-off-by: Liam Breck <kernel@networkimprov.net>
> 
> Looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Yeah me too:

Acked-by: Tony Lindgren <tony@atomide.com>
