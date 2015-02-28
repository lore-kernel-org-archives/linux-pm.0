From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] power: bq27x00_battery: add bq27510 support
Date: Sat, 28 Feb 2015 14:22:23 +0100
Message-ID: <20150228132223.GE4094@piout.net>
References: <1424614111-28613-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20150225221747.GP13695@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:55223 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751242AbbB1NWZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 28 Feb 2015 08:22:25 -0500
Content-Disposition: inline
In-Reply-To: <20150225221747.GP13695@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 25/02/2015 at 23:17:48 +0100, Sebastian Reichel wrote :
> > @@ -350,6 +378,9 @@ static int bq27x00_battery_read_cyct(struct bq27x00_device_info *di)
> >  {
> >  	int cyct;
> >  
> > +
> 
> spurious newline.
> 
> > +	if (di->chip == BQ27510)
> > +		cyct = bq27x00_read(di, BQ27510_REG_CYCT, false);
> >  	cyct = bq27x00_read(di, BQ27x00_REG_CYCT, false);
> 
> missing else?
> 

Indeed, I just sent v2. However, I'm not too happy with all that if/else
layering in this driver. I'll try to rework it so that it scales better.

Regards,

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
