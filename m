From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: RFC: WMI Enhancements
Date: Thu, 20 Apr 2017 15:14:31 +0200
Message-ID: <20170420131431.GM18887@pali>
References: <20170412230854.GA11963@fury>
 <20170419075248.GD18887@pali>
 <f3684c95b91349d3b4e512370ac1faf4@ausx13mpc120.AMER.DELL.COM>
 <201704191854.51783@pali>
 <4e3e507b116443298427002c5aafed7f@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4e3e507b116443298427002c5aafed7f@ausx13mpc120.AMER.DELL.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: dvhart@infradead.org, rjw@rjwysocki.net, luto@amacapital.net, len.brown@intel.com, corentin.chary@gmail.com, luto@kernel.org, andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 19 April 2017 17:24:00 Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: Pali Rohár [mailto:pali.rohar@gmail.com]
> > Sent: Wednesday, April 19, 2017 11:55 AM
> > To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> > Cc: dvhart@infradead.org; rjw@rjwysocki.net; luto@amacapital.net;
> > len.brown@intel.com; corentin.chary@gmail.com; luto@kernel.org;
> > andriy.shevchenko@linux.intel.com; linux-kernel@vger.kernel.org; platform-
> > driver-x86@vger.kernel.org; linux-pm@vger.kernel.org
> > Subject: Re: RFC: WMI Enhancements
> > 
> > On Wednesday 19 April 2017 18:29:53 Mario.Limonciello@dell.com wrote:
> > > > As wrote above, I'm fine with explicit whitelist of WMI GUIDs which
> > > > will be exported to userspace after communication with vendor.
> > >
> > > What about GUID's not yet used by kernel drivers?  Would those
> > > default to whitelist default to blacklist?  My preference would be
> > > to default to whitelist. This allows new GUID's to be added later
> > > without needing to modify kernel for something that kernel won't
> > > need to do anything immediately.
> > 
> > I understood it as there would be explicit whitelist in kernel and new
> > GUIDs would be needed to add into whitelist, even those which do not
> > have kernel wmi driver.
> > 
> > Exporting all GUIDs (to userspace) which are not bind to kernel driver
> > has one big problem. If kernel introduce new wmi driver for such GUID
> > then it block userspace to access it or at least would need to provide
> > audit filter and something would be probably filtered. It means that
> > some userspace applications which would use that GUIDs stops working
> > after upgrading to new kernel. And we can be in situation where *user*
> > need to decide: either use 3rd party userspace application from vendor
> > which provide some special settings for your laptop, or use kernel
> > module which provides standard rfkill/led/input class driver.
> > 
> 
> If this proposal goes forward it would sound like to me an audit filter
> would become a prerequisite for any new WMI kernel driver.  This is not
> a problem to me.

Not for any wmi driver, only for those which would like to export wmi
device to userspace.

> This audience recommends the way for users to configure the system but 
> of course cannot stop users from doing what they decide to do.  

Of course, but in above hypothetical example, user is in situation where
is unable to use both 3rd vendor application and together kernel
rfkill/led/input driver. User must decide (by e.g. modprobe blacklist or
manual module loading) what want to use.

But ideal solution is that both 3rd vendor application for firmware
settings and also rfkill kernel driver would work together without need
to rmmod/modprobe modules and without restarting 3rd vendor application.

> We're all in agreement that the kernel should keep responsibility for some
> of these functionalities.
> If a new kernel WMI driver duplicates functionality that happens to find its 
> way in userspace and the kernel audits that out yes the userspace 
> application may start to  have less functionality, but better support 
> would live in the kernel and the user would be better supported by 
> the stack (for example could use standard rfkill userspace utilities).

Ok. So it is acceptable solution/API/ABI for you & other Dell people?
Or is something more or different needed?

Darren, I hope that I understood your proposal with explicit whitelist
correctly. And is there already another vendor which want to use wmi
userspace on linux?

-- 
Pali Rohár
pali.rohar@gmail.com
