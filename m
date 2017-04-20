From: Darren Hart <dvhart@infradead.org>
Subject: Re: RFC: WMI Enhancements
Date: Thu, 20 Apr 2017 13:44:36 -0700
Message-ID: <20170420204436.GC3209@fury>
References: <20170412230854.GA11963@fury>
 <20170419075248.GD18887@pali>
 <f3684c95b91349d3b4e512370ac1faf4@ausx13mpc120.AMER.DELL.COM>
 <201704191854.51783@pali>
 <4e3e507b116443298427002c5aafed7f@ausx13mpc120.AMER.DELL.COM>
 <20170420131431.GM18887@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:41716 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S946403AbdDTUol (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Apr 2017 16:44:41 -0400
Content-Disposition: inline
In-Reply-To: <20170420131431.GM18887@pali>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Mario.Limonciello@dell.com, rjw@rjwysocki.net, luto@amacapital.net, len.brown@intel.com, corentin.chary@gmail.com, luto@kernel.org, andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org

On Thu, Apr 20, 2017 at 03:14:31PM +0200, Pali Rohár wrote:
> On Wednesday 19 April 2017 17:24:00 Mario.Limonciello@dell.com wrote:
> > > -----Original Message-----
> > > From: Pali Rohár [mailto:pali.rohar@gmail.com]
> > > Sent: Wednesday, April 19, 2017 11:55 AM
> > > To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> > > Cc: dvhart@infradead.org; rjw@rjwysocki.net; luto@amacapital.net;
> > > len.brown@intel.com; corentin.chary@gmail.com; luto@kernel.org;
> > > andriy.shevchenko@linux.intel.com; linux-kernel@vger.kernel.org; platform-
> > > driver-x86@vger.kernel.org; linux-pm@vger.kernel.org
> > > Subject: Re: RFC: WMI Enhancements
> > > 
> > > On Wednesday 19 April 2017 18:29:53 Mario.Limonciello@dell.com wrote:
> > > > > As wrote above, I'm fine with explicit whitelist of WMI GUIDs which
> > > > > will be exported to userspace after communication with vendor.
> > > >
> > > > What about GUID's not yet used by kernel drivers?  Would those
> > > > default to whitelist default to blacklist?  My preference would be
> > > > to default to whitelist. This allows new GUID's to be added later
> > > > without needing to modify kernel for something that kernel won't
> > > > need to do anything immediately.
> > > 
> > > I understood it as there would be explicit whitelist in kernel and new
> > > GUIDs would be needed to add into whitelist, even those which do not
> > > have kernel wmi driver.
> > > 
> > > Exporting all GUIDs (to userspace) which are not bind to kernel driver
> > > has one big problem. If kernel introduce new wmi driver for such GUID
> > > then it block userspace to access it or at least would need to provide
> > > audit filter and something would be probably filtered. It means that
> > > some userspace applications which would use that GUIDs stops working
> > > after upgrading to new kernel. And we can be in situation where *user*
> > > need to decide: either use 3rd party userspace application from vendor
> > > which provide some special settings for your laptop, or use kernel
> > > module which provides standard rfkill/led/input class driver.
> > > 
> > 
> > If this proposal goes forward it would sound like to me an audit filter
> > would become a prerequisite for any new WMI kernel driver.  This is not
> > a problem to me.
> 
> Not for any wmi driver, only for those which would like to export wmi
> device to userspace.

Correct.

> 
> > This audience recommends the way for users to configure the system but 
> > of course cannot stop users from doing what they decide to do.  
> 
> Of course, but in above hypothetical example, user is in situation where
> is unable to use both 3rd vendor application and together kernel
> rfkill/led/input driver. User must decide (by e.g. modprobe blacklist or
> manual module loading) what want to use.
> 
> But ideal solution is that both 3rd vendor application for firmware
> settings and also rfkill kernel driver would work together without need
> to rmmod/modprobe modules and without restarting 3rd vendor application.
> 
> > We're all in agreement that the kernel should keep responsibility for some
> > of these functionalities.
> > If a new kernel WMI driver duplicates functionality that happens to find its 
> > way in userspace and the kernel audits that out yes the userspace 
> > application may start to  have less functionality, but better support 
> > would live in the kernel and the user would be better supported by 
> > the stack (for example could use standard rfkill userspace utilities).
> 

Pali has raised a very good point which I want to get some feedback from Linus,
and perhaps tglx, hpa, and gregkh on. While Mario is expressing a very pragmatic
approach which I certainly appreciate, we have a very strong position that we do
not break userspace.

There have been exceptions for specific pseudo filesystems and such, but they
are rare. We would need to document the WMI commitment from the kernel to
userspace (e.g. any call may be filtered based on current Linux kernel WMI
usage, which may change over time). This sounds troublesome... will give this
some more thought.

> Ok. So it is acceptable solution/API/ABI for you & other Dell people?
> Or is something more or different needed?
> 
> Darren, I hope that I understood your proposal with explicit whitelist
> correctly. And is there already another vendor which want to use wmi
> userspace on linux?

It might be moot with Christoph's dynamic ID comment which I need to go review
in detail. Putting that aside for a moment, what I intended was for the platform
driver to whitelist GUIDs. But, that doesn't necessarily mean it has an explicit
list. The platform driver could have a blacklist and then walk through all
available GUIDs and export everything except those on the blacklist.

Now with Christoph's idea, we may be able to maintain a blacklist of GUIDs and a
whitelist of platforms which CAN export WMI, but not export any until userspace
requests a specific GUID be exported at which point it is checked against the
blacklist and then exported accordingly, at which point the WMI method filters
handle the rest.

> 
> -- 
> Pali Rohár
> pali.rohar@gmail.com
> 

-- 
Darren Hart
VMware Open Source Technology Center
