From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 01/13] thermal: Make temperatures consistently unsigned
 long
Date: Mon, 27 Apr 2015 22:36:08 +0200
Message-ID: <20150427203608.GD29351@xo-6d-61-c0.localdomain>
References: <1427385240-6086-1-git-send-email-s.hauer@pengutronix.de>
 <1427385240-6086-2-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427385240-6086-2-git-send-email-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu 2015-03-26 16:53:48, Sascha Hauer wrote:
> The thermal framework uses int, long and unsigned long for temperatures
> in millicelsius. The majority of functions uses unsigned long, so change
> the remaining functions to use this type aswell.

Maybe millicelsius_t should be introduced, so that readers immediately know
what type it is? Some parts of kernel also use decicelsius and decikelvin, IIRC (ACPI).

									Pavel

>  	if (trip_type == THERMAL_TRIP_CRITICAL) {
>  		dev_emerg(&tz->device,
> -			  "critical temperature reached(%d C),shutting down\n",
> +			  "critical temperature reached(%lu C),shutting down\n",

space after , ?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
