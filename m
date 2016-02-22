From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: generic-adc-battery volatge-to-percent formula
Date: Mon, 22 Feb 2016 06:58:13 +0100
Message-ID: <7720041C-DFEC-4592-A5AE-0C2BEEFB6049@goldelico.com>
References: <CAAfyv37rjchL=FtvgGhjrfXnCvhfbYCext48QmSuOgJ5RjTwAQ@mail.gmail.com> <20160212085157.GA16326@amd> <CAAfyv34=C5NSTuqR9Pf4MT2Z42XvT_1Gw+kyjZZh12zC2cBoFA@mail.gmail.com> <20160215115304.GA5014@amd> <20160221200653.GD15242@earth> <0BD7A329-A8BE-4B3E-B98F-CAB7A25F643F@goldelico.com> <20160221211257.GA26418@amd>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:15776 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224AbcBVF6Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2016 00:58:24 -0500
In-Reply-To: <20160221211257.GA26418@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, Belisko Marek <marek.belisko@gmail.com>, Linux PM mailing list <linux-pm@vger.kernel.org>

Hi,

Am 21.02.2016 um 22:12 schrieb Pavel Machek <pavel@ucw.cz>:

> Hi!
> 
>> 
>> it could be something similar to (I might have made a mistake when applying scaling):
>> 
>> /* calculate remaining fuel level (in %) of a LiIon battery assuming
>> * a standard chemistry model
>> *    http://cseweb.ucsd.edu/~trosing/lectures/battery.pdf
>> *
>> * @mV: voltage measured outside the battery
>> * @mA: current flowing out of the battery
>> * @mOhm: assumed series resitance of the battery
>> *
>> * returns value between 0 and 100
>> */
>> 
>> static inline int fuel_level_LiIon(int mV, int mA, int mOhm) {
>> 	int u;
>> 	/* internal battery voltage is higher than measured */
> 
> add " when discharging".
> 
>> 	mV += (mOhm * mA) /1000;
>> 
>> 	/* apply formula */
>> 	u = 3870000 - (14523 * (37835 - 10 * mV));
> 
> 	/* linear approximation between 3.756V */

/* use linear approx. below 3.756V / 19.66% assuming 3.3V / 0% */

> 
>> 	if (u < 0)

I just recognised that we should for a really robust formula
also limit the linear approx. to 0 if someone measures <3300 mV.

>> 		return ((mV - 3300) * ((3756 - 3300) * 1966)) / 100000;

		return max(((mV - 3300) * ((3756 - 3300) * 1966)) / 100000, 0);


>> 	return (1966 + sqrt(u))/100;

and this should be limited to 100.

return min((1966 + int_sqrt(u))/100, 100);

>> }
>> 

To which header file should this go?

-- hns