From: David Brownell <david-b@pacbell.net>
Subject: Re: Re: [2.6.22-rc1-mm1] vaio laptop (SZ72B) immediately
	resumes after STR
Date: Fri, 22 Jun 2007 02:43:55 -0700
Message-ID: <200706220243.56056.david-b__39047.1884551973$1182505488$gmane$org@pacbell.net>
References: <20070621064215.GB9050@inferi.kami.home>
	<Pine.LNX.4.44L0.0706211132470.3547-100000@iolanthe.rowland.org>
	<20070622092258.GC25100@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070622092258.GC25100@inferi.kami.home>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mattia Dongili <malattia@linux.it>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org


> > > Just to simplify, in this situation, if I had an usb mouse attached to
> > > this usb controller and removed the mouse while suspended, would the
> > > laptop wakeup?
> > 
> > If the USB controller was enabled for wakeup and was working correctly,
> > it would wake up the laptop.  USB wakeup events are defined as: new
> > connection, disconnection, overcurrent, plus any wakeup requests
> > received from devices on the USB bus.
> > 
> > > If so that's not what I most probably want. :)

You have a workaround in hand to achieve what you want.


> > Maybe we should change the kernel so that the default wakeup setting 
> > for USB controllers is disabled. 

I'd rather not go that route.  It may well be that there's
something odd in the current handling of wakeup events with
EHCI.  I've not personally touched that particular code in
several years now, and a lot of code round it has changed
since then.  Plus of course, problems that don't reproduce
on my hardware can't get much attention from me ... there's
something like a factor of ten or more in terms of effort
to do that sort of remote debugging.


> > Then people would have to enable  
> > wakeup explicitly if they wanted to be able to start up their system by 
> > typing on a USB keyboard, for instance.
> 
> Don't know, I guess this could be easy automated in userspace actually.
> But if connect/disconnect are wakeup events my vote goes to default to
> disabled for usb controllers and manage selective enable with some nice
> userspace tool. Not that my opinion counts that much :)

A userspace tool would certainly be doable.  That's part of why
the sysfs wakeup attributes exist:  to cope with hardware oddities
the kernel doesn't know about, or to cope with user preferences.

- Dave
