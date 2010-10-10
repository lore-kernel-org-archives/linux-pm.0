From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] pm_trace: Add sysfs attr for rechecking
	dev hash.
Date: Sun, 10 Oct 2010 22:47:19 +0200
Message-ID: <20101010204719.GA3388__2024.26372929967$1286743698$gmane$org@elf.ucw.cz>
References: <201010092334.27808.james@albanarts.com>
	<201010092337.47821.james@albanarts.com>
	<20101010180400.GA19524@elf.ucw.cz>
	<201010102047.01950.james@albanarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201010102047.01950.james@albanarts.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: James Hogan <james@albanarts.com>, Greg KH <greg@kroah.com>
Cc: Len Brown <len.brown@intel.com>, markgross <markgross@thegnar.org>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun 2010-10-10 20:47:01, James Hogan wrote:
> Hi Pavel,
> 
> On Sunday 10 October 2010 19:04:00 Pavel Machek wrote:
> > Hi!
> > 
> > > If the device which fails to resume is part of a loadable kernel module
> > > it won't be checked at startup against the magic number stored in the
> > > RTC.
> > > 
> > > Add a read-only sysfs attribute /sys/power/pm_trace_dev_hash which
> > > contains a list of newline separated devices (usually just the one)
> > > which currently match the last magic number. This allows the device
> > > which is failing to resume to be found after the modules are loaded
> > > again.
> > > 
> > > --- a/Documentation/power/s2ram.txt
> > > +++ b/Documentation/power/s2ram.txt
> > > 
> > > @@ -49,6 +49,13 @@ machine that doesn't boot) is:
> > >     device (lspci and /sys/devices/pci* is your friend), and see if you
> > >     can fix it, disable it, or trace into its resume function.
> > > 
> > > +   If no device matches the hash, it may be a device from a loadable
> > > kernel +   module that is not loaded until after the hash is checked.
> > > You can check +   the hash against the current devices again after more
> > > modules are loaded +   using sysfs:
> > > +
> > > +	cat /sys/power/pm_trace_dev_hash
> > > +
> > 
> > Yep, but exact semantics of that sysfs file should probably be linked
> > in the sysfs documentation...
> > 								Pavel
> 
> To clarify, do you mean I should link to Documentation/ABI/testing/sysfs-power 
> from Documentation/power/s2ram.txt, or just make sure the syfs file is 
> documented in Documentation/ABI/testing/sysfs-power (which is done in v2 of 
> this patch)?

v2 of the patch is probably ok.

Also, sysfs should be one entry per file, and strictly speaking, this
one is not. That may be fine... but as this is debugging facility,
perhaps it should go to debugfs? Maybe cc gregkh...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
