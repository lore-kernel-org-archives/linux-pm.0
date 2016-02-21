From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: generic-adc-battery volatge-to-percent formula
Date: Sun, 21 Feb 2016 21:36:56 +0100
Message-ID: <0BD7A329-A8BE-4B3E-B98F-CAB7A25F643F@goldelico.com>
References: <CAAfyv37rjchL=FtvgGhjrfXnCvhfbYCext48QmSuOgJ5RjTwAQ@mail.gmail.com> <20160212085157.GA16326@amd> <CAAfyv34=C5NSTuqR9Pf4MT2Z42XvT_1Gw+kyjZZh12zC2cBoFA@mail.gmail.com> <20160215115304.GA5014@amd> <20160221200653.GD15242@earth>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:11894 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbcBUUhG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 21 Feb 2016 15:37:06 -0500
In-Reply-To: <20160221200653.GD15242@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Belisko Marek <marek.belisko@gmail.com>, Linux PM mailing list <linux-pm@vger.kernel.org>

Hi,

Am 21.02.2016 um 21:06 schrieb Sebastian Reichel <sre@kernel.org>:

> Hi,
> 
> On Mon, Feb 15, 2016 at 12:53:04PM +0100, Pavel Machek wrote:
>>>>> some time ago I did post series which added some conversion table from
>>>>> voltage to percent for charging and discharging states [1] in
>>>>> twl4030_madc driver. This approach was not accepted and we still want
>>>>> to have something like that in kernel. We re-think re-thinking
>>>>> original idea and also get reference where Pavel point us to formula
>>>>> which could be used for computing voltage-to-percent conversion [2]
>>>>> 
>>>>> What about adding this formula as a default for the
>>>>> voltage-to-percent-conversion to the generic-adc-battery
>>>>> driver (and converting it to DT)? Would that be a better
>>>>> solution than a table driven and twl4030 only driver?
>>>> 
>>>> I'd say battery, yes. And maybe even better would be putting it into
>>>> lib/ or seaparet driver, as it does not really depend on IIO? You just
>>>> supply voltage, current and internal resistance, and it produces number...

it could be something similar to (I might have made a mistake when applying scaling):

/* calculate remaining fuel level (in %) of a LiIon battery assuming
* a standard chemistry model
*    http://cseweb.ucsd.edu/~trosing/lectures/battery.pdf
*
* @mV: voltage measured outside the battery
* @mA: current flowing out of the battery
* @mOhm: assumed series resitance of the battery
*
* returns value between 0 and 100
*/

static inline int fuel_level_LiIon(int mV, int mA, int mOhm) {
	int u;
	/* internal battery voltage is higher than measured */
	mV += (mOhm * mA) /1000;

	/* apply formula */
 	u = 3870000 - (14523 * (37835 - 10 * mV));
	if (u < 0)
		return ((mV - 3300) * ((3756 - 3300) * 1966)) / 100000;
	return (1966 + sqrt(u))/100;
}

>>>> 
>>> Can we put this small helper to some common power header file
>>> which can be then included to driver which can use this formula.
>>> I think it's better way then adding it to /lib as it won't be
>>> used in whole kernel tree just in power. What do you think?
>>> Thanks.
>> 
>> Sounds good to me.
> 
> Sounds fine for me, too.

Fine for me as well.

And the generic-adc-battery can use it as a default translation function
when initialized by device tree (which provides the mOhm value as well).

-- hns