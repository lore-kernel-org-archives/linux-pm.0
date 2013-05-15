From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 3.10-rc1 system starts regular boot when waking from s2ram
Date: Wed, 15 May 2013 11:05:05 +0200
Message-ID: <20130515090505.GA3995@amd.pavel.ucw.cz>
References: <20130514160108.GA5055@dhcp22.suse.cz>
 <1368567715.t1rym2H3RB@vostro.rjw.lan>
 <20130515080122.GC8625@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130515080122.GC8625@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Hocko <mhocko@suse.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Well, it probably is.  I'll try to reproduce it, but if I can't ...
> 
> OK, I am bisecting now. 6 iterations left...

Good luck. I tried to reproduce it locally on thinkpad x60, but it
suspends/resumes ok.

(There seems to be regression in bluetooth; tray widget now shows
bluetooth is unavailable and it can't be turned on. x60 uses btusb.)

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
