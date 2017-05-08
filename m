From: Darren Hart <dvhart@infradead.org>
Subject: Re: RFC: WMI Enhancements
Date: Mon, 8 May 2017 08:29:07 -0700
Message-ID: <20170508152907.GA17700@fury>
References: <20170419075248.GD18887@pali>
 <f3684c95b91349d3b4e512370ac1faf4@ausx13mpc120.AMER.DELL.COM>
 <201704191854.51783@pali>
 <4e3e507b116443298427002c5aafed7f@ausx13mpc120.AMER.DELL.COM>
 <20170420131431.GM18887@pali>
 <20170420204436.GC3209@fury>
 <775ffd8f3327497cabd15ee7826cedaf@ausx13mpc120.AMER.DELL.COM>
 <20170505234436.GB25865@fury>
 <beb9a835eaf243fab151627e919eccf3@ausx13mpc120.AMER.DELL.COM>
 <CALCETrUgPgk7uVdYx4zJzXQHpk5zALmzSp3Zcz9+FPAe6bA5LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:39512 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752367AbdEHP3N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2017 11:29:13 -0400
Content-Disposition: inline
In-Reply-To: <CALCETrUgPgk7uVdYx4zJzXQHpk5zALmzSp3Zcz9+FPAe6bA5LQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Mario.Limonciello@dell.com, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Corentin Chary <corentin.chary@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Fri, May 05, 2017 at 06:25:08PM -0700, Andy Lutomirski wrote:
> On Fri, May 5, 2017 at 5:51 PM,  <Mario.Limonciello@dell.com> wrote:
> >> -----Original Message-----
> >> From: Darren Hart [mailto:dvhart@infradead.org]
> >> Sent: Friday, May 5, 2017 6:45 PM
> >> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> >> Cc: pali.rohar@gmail.com; rjw@rjwysocki.net; luto@amacapital.net;
> >> len.brown@intel.com; corentin.chary@gmail.com; luto@kernel.org;
> >> andriy.shevchenko@linux.intel.com; linux-kernel@vger.kernel.org; platform-
> >> driver-x86@vger.kernel.org; linux-pm@vger.kernel.org
> >> Subject: Re: RFC: WMI Enhancements
> 
> 
> > I meant that to say that at least for now Andy's wmi-mof driver should still be merged.
> > If something is going to build on top of this to do WBEM tools, they'll need that MOF
> > data once someone figures out how to nicely deconstruct it.
> >
> 
> The thing I don't like about my own driver is that, as a WMI device
> driver, it can be loaded before the rest of the bus finishes probing.
> So user programs that are notified asynchronously that the wmi-mof
> driver is loaded and try to use future functionality (ioctl to issue a
> MOF-based method call?) might end up doing so before the rest of the
> bus is probed.
> 
> This could be addressed by always exposing the wmi-mof device last
> (sort of -- it can be a module) or perhaps by moving MOF functionality
> to the core driver.  Or maybe it's not really a problem.

Thanks Andy, I'll keep that in mind and see if I can come up with something to
address it while working on WMI this week.

The other problem with wmi-mof is that there will be no immediate open source
consumers of the interface, and none on the horizon. We can't even test it to
any meaningful degree on Linux. I suspect this will be met with stiff
resistance.

> 
> Also, isn't there a way to ask Microsoft to document this?  Are you
> supposed to "ask a question" on this forum, perhaps:
> 
> https://msdn.microsoft.com/en-us/library/gg134029.aspx
> 
> I'm guessing the Samba team knows how to do this, too.
> 

It's a start.

-- 
Darren Hart
VMware Open Source Technology Center
