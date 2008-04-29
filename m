From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.25-mm1: suspend-to-disk warning, resume failure
Date: Tue, 29 Apr 2008 22:20:24 +0200
Message-ID: <200804292220.25725.rjw__18732.1832207546$1209500666$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0804181116590.6252-100000@iolanthe.rowland.org>
	<200804190116.17095.rjw@sisk.pl> <20080428232917.GA4171@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080428232917.GA4171@kroah.com>
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
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, USB list <linux-usb@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, 29 of April 2008, Greg KH wrote:
> On Sat, Apr 19, 2008 at 01:16:16AM +0200, Rafael J. Wysocki wrote:
> > On Saturday, 19 of April 2008, Greg KH wrote:
> > > On Fri, Apr 18, 2008 at 11:30:39PM +0200, Rafael J. Wysocki wrote:
> > > > On Friday, 18 of April 2008, Greg KH wrote:
> > > > > > ---
> > > > > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > > > > 
> > > > > > Make hibernation work as documented in include/linux/pm.h .
> > > > > > 
> > > > > > In pm.h it is documented that device_power_up() and device_resume()
> > > > > > will be called with PMSG_RECOVER if the creation of a hibernation
> > > > > > image fails or the restoration of memory contents from a
> > > > > > hibernation image fails.  Otherwise, it should be called either
> > > > > > with PMSG_THAW or with PMSG_RESTORE, depending on the context.
> > > > > > Make that happen.
> > > > > 
> > > > > Should either of these patches be merged / added to the ones you sent me
> > > > > before?
> > > > 
> > > > Yes, both of them, please.
> > > 
> > > Ok, which is it?  Added at the end of the series, or merged in to
> > > prevent git bisection problems?  If merged, which patch should I merge
> > > it to?
> > 
> > Please merge both into
> > pm-introduce-new-top-level-suspend-and-hibernation-callbacks.patch ,
> > if possible, the changes belong in there.
> 
> Hm, I just tried this (sorry for the delay) and I think it's no longer
> needed with your latest version of the patches, right?

Right.  The last version already contains it.

Thanks,
Rafael
