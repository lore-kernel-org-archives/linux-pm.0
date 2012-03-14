From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [linux-pm] [PATCH V3] cpuidle: Add a sysfs entry to disable
 specific C state for debug purpose.
Date: Tue, 13 Mar 2012 19:46:19 -0700
Message-ID: <20120314024619.GC22955@kroah.com>
References: <CAGF5oy_BUytjeDa8Oc62pRabaEqwqKCFuVJuzLd-XNZg34ne2w@mail.gmail.com>
 <1330998885.1916.89.camel@ymzhang>
 <20120306052236.GA19416@kroah.com>
 <1331013078.1916.103.camel@ymzhang>
 <20120306143935.GA23346@kroah.com>
 <20120312181151.GE14020@sirena.org.uk>
 <20120312192936.GC24873@kroah.com>
 <1331602594.1916.155.camel@ymzhang>
 <20120313192949.GA8568@kroah.com>
 <1331686500.1916.172.camel@ymzhang>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1331686500.1916.172.camel@ymzhang>
Sender: linux-kernel-owner@vger.kernel.org
To: Yanmin Zhang <yanmin_zhang@linux.intel.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, "Brown, Len" <len.brown@intel.com>, ShuoX Liu <shuox.liu@intel.com>, Ingo Molnar <mingo@elte.hu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "H. Peter Anvin" <hpa@zytor.com>, andi.kleen@intel.com, Thomas Gleixner <tglx@linutronix.de>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 14, 2012 at 08:55:00AM +0800, Yanmin Zhang wrote:
> On Tue, 2012-03-13 at 12:29 -0700, Greg KH wrote:
> > On Tue, Mar 13, 2012 at 09:36:34AM +0800, Yanmin Zhang wrote:
> > > On Mon, 2012-03-12 at 12:29 -0700, Greg KH wrote:
> > > > On Mon, Mar 12, 2012 at 06:11:51PM +0000, Mark Brown wrote:
> > > > > On Tue, Mar 06, 2012 at 06:39:35AM -0800, Greg KH wrote:
> > > > > 
> > > > > > Do you know of any tools using these files?  I have never heard of them,
> > > > > > and I was told we should move these files years ago.  So I don't think
> > > > > > there should be any api issues.
> > > > > 
> > > > > powertop uses them.
> > > > 
> > > > Ok, then we can't move them all.
> > > > 
> > > > We should then just move the ones that have multiple lines, as I'm
> > > > pretty sure powertop doesn't use them, right?
> > > All sys files under cpu/cpuXXX/cpuidle have single line. If we move
> > > some files to debugfs and keep others under sysfs, users might be confused.
> > > 
> > > Should we go back to the 1st version which just adds the new entry to
> > > sysfs?
> > 
> > Wait, I thought this whole thing started when we wanted to move the
> > files that had multiple lines out of sysfs?
> No. Liu Shuo's patch adds a new entry under cpu/cpuXXX/cpuidle and users
> can disable specific C state.
> A gentleman raised that if we should move it to debugfs, then you suggested
> to move all files under cpu/cpuXXX/cpuidle to debugfs.
> 
> > 
> > If none of these do, and they all are being used by tools already, then
> > fine, they should stay.
> Agree.
> 
> > 
> > But for some reason, I thought there was a problem here.  Perhaps that
> > was in the cpufreq code?
> I checked cpufreq quickly. Every file has single-line, but some have
> multiple-fields.
> 
> We would send a new patch based on sysfs as the new entry has
> single line.

Then that's fine, I'm very sorry for getting this wrong the first time
and causing you extra work.  I owe you all the drink of your choice the
next time I see you.

greg k-h
