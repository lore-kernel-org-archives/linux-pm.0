From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 01/13] thermal: Make temperatures consistently unsigned
 long
Date: Tue, 28 Apr 2015 09:42:24 +0200
Message-ID: <20150428074224.GI6325@pengutronix.de>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
 <1427385240-6086-2-git-send-email-s.hauer@pengutronix.de>
 <20150427203608.GD29351@xo-6d-61-c0.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58035 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932287AbbD1Hmb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Apr 2015 03:42:31 -0400
Content-Disposition: inline
In-Reply-To: <20150427203608.GD29351@xo-6d-61-c0.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Mon, Apr 27, 2015 at 10:36:08PM +0200, Pavel Machek wrote:
> On Thu 2015-03-26 16:53:48, Sascha Hauer wrote:
> > The thermal framework uses int, long and unsigned long for temperatures
> > in millicelsius. The majority of functions uses unsigned long, so change
> > the remaining functions to use this type aswell.
> 
> Maybe millicelsius_t should be introduced, so that readers immediately know
> what type it is? Some parts of kernel also use decicelsius and decikelvin, IIRC (ACPI).

I have no strong opinion on this. I'll send out the next version without
typedef for now. Since in my patch I identified most places which need a
type change anyway it might be a good opportunity to change to a typedef
if we want to. Any other opinions on this?

> 
> 									Pavel
> 
> >  	if (trip_type == THERMAL_TRIP_CRITICAL) {
> >  		dev_emerg(&tz->device,
> > -			  "critical temperature reached(%d C),shutting down\n",
> > +			  "critical temperature reached(%lu C),shutting down\n",
> 
> space after , ?

Turns out that in the new version of this series I don't have to modify
this line anymore. Made this a separate patch.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
