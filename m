From: Pavel Machek <pavel@ucw.cz>
Subject: Re: generic-adc-battery volatge-to-percent formula
Date: Fri, 12 Feb 2016 09:51:58 +0100
Message-ID: <20160212085157.GA16326@amd>
References: <CAAfyv37rjchL=FtvgGhjrfXnCvhfbYCext48QmSuOgJ5RjTwAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60102 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbcBLIwA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Feb 2016 03:52:00 -0500
Content-Disposition: inline
In-Reply-To: <CAAfyv37rjchL=FtvgGhjrfXnCvhfbYCext48QmSuOgJ5RjTwAQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Linux PM mailing list <linux-pm@vger.kernel.org>

Hi!
> 
> some time ago I did post series which added some conversion table from
> voltage to percent for charging and discharging states [1] in
> twl4030_madc driver. This approach was not accepted and we still want
> to have something like that in kernel. We re-think re-thinking
> original idea and also get reference where Pavel point us to formula
> which could be used for computing voltage-to-percent conversion [2]
> 
> What about adding this formula as a default for the
> voltage-to-percent-conversion to
> the generic-adc-battery driver (and converting it to DT)? Would that
> be a better solution than a table driven and twl4030 only driver?

I'd say battery, yes. And maybe even better would be putting it into
lib/ or seaparet driver, as it does not really depend on IIO? You just
supply voltage, current and internal resistance, and it produces number...

I'm using the same conversion tables on n900 (it has battery gauge,
but it is often not calibrated, so fallback method is nice), and it
seems to work quite ok.

Best regards,
									Pavel    
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
