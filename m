From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/6] power: bq24190_charger: Check the interrupt status
 on resume
Date: Thu, 12 Jan 2017 07:49:39 -0800
Message-ID: <20170112154938.GE2630@atomide.com>
References: <20170112004154.31568-1-tony@atomide.com>
 <20170112004154.31568-6-tony@atomide.com>
 <CAKvHMgRbmAxHvJ3NoTs2JMkK3VN_mERtsmJxi7184KfbbnHkGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:56560 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750873AbdALPtm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 12 Jan 2017 10:49:42 -0500
Content-Disposition: inline
In-Reply-To: <CAKvHMgRbmAxHvJ3NoTs2JMkK3VN_mERtsmJxi7184KfbbnHkGg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, "Mark A . Greer" <mgreer@animalcreek.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Liam Breck <kernel@networkimprov.net>

* Liam Breck <liam@networkimprov.net> [170111 18:06]:
> > @@ -1404,6 +1410,7 @@ static int bq24190_probe(struct i2c_client *client,
> >         }
> >
> >         enable_irq(bdi->irq);
> > +       bdi->initialized = 1;
> 
> Should initialized be set before enable_irq()?

Yes good catch will check.

Thanks,

Tony
