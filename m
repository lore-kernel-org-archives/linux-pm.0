From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH RFC] PM / Hibernate: no kernel_power_off when
 pm_power_off NULL
Date: Sun, 20 Apr 2014 16:06:12 +0200
Message-ID: <20140420140612.GB14594@amd.pavel.ucw.cz>
References: <CADHgK6uXg0CXZC5s5Z5Kpy6dYH58UChL-p9ozCCcoUU=-0KJYw@mail.gmail.com>
 <CADHgK6sh6TUc4jBQFQHTQuhze9=r2FBzF6aULUc_c+bbWYjp5w@mail.gmail.com>
 <CADHgK6sCmPVZ--eyEnqnjfs_4C_PfHTgAUQ_Nb4oJP0mBDnQUw@mail.gmail.com>
 <20140415205453.GX24070@n2100.arm.linux.org.uk>
 <20140415211832.GA32213@amd.pavel.ucw.cz>
 <CADHgK6vzagyELYGnVoHvfnK9G57-NSycOaKsNQ53rnU1pOwn=Q@mail.gmail.com>
 <20140416204119.GJ24070@n2100.arm.linux.org.uk>
 <20140416215718.7f58efd8@alan.etchedpixels.co.uk>
 <20140416210901.GK24070@n2100.arm.linux.org.uk>
 <CADHgK6urB0wHFzTXakGqT9GA91=E-rSwnDqY-4xcjQS8Sijs-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52640 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbaDTOGN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 20 Apr 2014 10:06:13 -0400
Content-Disposition: inline
In-Reply-To: <CADHgK6urB0wHFzTXakGqT9GA91=E-rSwnDqY-4xcjQS8Sijs-Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Capella <sebastian.capella@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

On Fri 2014-04-18 14:38:34, Sebastian Capella wrote:
> Thanks Russell, Alan!
> 
> So we're OK with the current patch + replacing while(1) after
> kernel_halt at the end of power_down in hibernate.c with a while (1)
> cpu_relax()?
> 
> Any other changes needed?
> 
> If not, I'll send a follow up patch with just these.

That sounds like a plan. Thanks.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
