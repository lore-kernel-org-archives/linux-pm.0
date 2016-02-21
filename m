From: Pavel Machek <pavel@ucw.cz>
Subject: Re: generic-adc-battery volatge-to-percent formula
Date: Sun, 21 Feb 2016 22:12:57 +0100
Message-ID: <20160221211257.GA26418@amd>
References: <CAAfyv37rjchL=FtvgGhjrfXnCvhfbYCext48QmSuOgJ5RjTwAQ@mail.gmail.com>
 <20160212085157.GA16326@amd>
 <CAAfyv34=C5NSTuqR9Pf4MT2Z42XvT_1Gw+kyjZZh12zC2cBoFA@mail.gmail.com>
 <20160215115304.GA5014@amd>
 <20160221200653.GD15242@earth>
 <0BD7A329-A8BE-4B3E-B98F-CAB7A25F643F@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42394 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbcBUVNB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 21 Feb 2016 16:13:01 -0500
Content-Disposition: inline
In-Reply-To: <0BD7A329-A8BE-4B3E-B98F-CAB7A25F643F@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sebastian Reichel <sre@kernel.org>, Belisko Marek <marek.belisko@gmail.com>, Linux PM mailing list <linux-pm@vger.kernel.org>

Hi!

> 
> it could be something similar to (I might have made a mistake when applying scaling):
> 
> /* calculate remaining fuel level (in %) of a LiIon battery assuming
> * a standard chemistry model
> *    http://cseweb.ucsd.edu/~trosing/lectures/battery.pdf
> *
> * @mV: voltage measured outside the battery
> * @mA: current flowing out of the battery
> * @mOhm: assumed series resitance of the battery
> *
> * returns value between 0 and 100
> */
> 
> static inline int fuel_level_LiIon(int mV, int mA, int mOhm) {
> 	int u;
> 	/* internal battery voltage is higher than measured */

add " when discharging".

> 	mV += (mOhm * mA) /1000;
> 
> 	/* apply formula */
>  	u = 3870000 - (14523 * (37835 - 10 * mV));

	/* linear approximation between 3.756V */

> 	if (u < 0)
> 		return ((mV - 3300) * ((3756 - 3300) * 1966)) / 100000;
> 	return (1966 + sqrt(u))/100;
> }
>

Thanks,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
