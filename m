From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: generic-adc-battery volatge-to-percent formula
Date: Mon, 15 Feb 2016 09:52:47 +0100
Message-ID: <CAAfyv34=C5NSTuqR9Pf4MT2Z42XvT_1Gw+kyjZZh12zC2cBoFA@mail.gmail.com>
References: <CAAfyv37rjchL=FtvgGhjrfXnCvhfbYCext48QmSuOgJ5RjTwAQ@mail.gmail.com>
	<20160212085157.GA16326@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:33144 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480AbcBOIwt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2016 03:52:49 -0500
Received: by mail-wm0-f46.google.com with SMTP id g62so139211850wme.0
        for <linux-pm@vger.kernel.org>; Mon, 15 Feb 2016 00:52:48 -0800 (PST)
In-Reply-To: <20160212085157.GA16326@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Linux PM mailing list <linux-pm@vger.kernel.org>

Hi Pavel,

On Fri, Feb 12, 2016 at 9:51 AM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>>
>> some time ago I did post series which added some conversion table from
>> voltage to percent for charging and discharging states [1] in
>> twl4030_madc driver. This approach was not accepted and we still want
>> to have something like that in kernel. We re-think re-thinking
>> original idea and also get reference where Pavel point us to formula
>> which could be used for computing voltage-to-percent conversion [2]
>>
>> What about adding this formula as a default for the
>> voltage-to-percent-conversion to
>> the generic-adc-battery driver (and converting it to DT)? Would that
>> be a better solution than a table driven and twl4030 only driver?
>
> I'd say battery, yes. And maybe even better would be putting it into
> lib/ or seaparet driver, as it does not really depend on IIO? You just
> supply voltage, current and internal resistance, and it produces number...
Can we put this small helper to some common power header file which
can be then included
to driver which can use this formula. I think it's better way then
adding it to /lib as it won't be used
in whole kernel tree just in power. What do you think? Thanks.
>
> I'm using the same conversion tables on n900 (it has battery gauge,
> but it is often not calibrated, so fallback method is nice), and it
> seems to work quite ok.
+1
>
> Best regards,
>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

BR,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
