From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] create /sys/.../power when CONFIG_PM is set
Date: Fri, 9 Nov 2007 13:32:23 -0800
Message-ID: <20071109213223.GA28276__45566.815758548$1194646201$gmane$org@kroah.com>
References: <20071107101043.2E64C9D4ECC@zog.reactivated.net>
	<20071109130555.5304d49a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071109130555.5304d49a.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-hotplug-devel@lists.sourceforge.net, kay.sievers@vrfy.org, linux-kernel@vger.kernel.org, Daniel Drake <dsd@gentoo.org>, linux-pm@lists.linux-foundation.org, oneukum@suse.de
List-Id: linux-pm@vger.kernel.org

On Fri, Nov 09, 2007 at 01:05:55PM -0800, Andrew Morton wrote:
> On Wed,  7 Nov 2007 10:10:43 +0000 (GMT)
> Daniel Drake <dsd@gentoo.org> wrote:
> 
> > The CONFIG_SUSPEND changes in 2.6.23 caused a regression under certain
> > configuration conditions (SUSPEND=n, USB_AUTOSUSPEND=y) where all USB device
> > attributes in sysfs (idVendor, idProduct, ...) silently disappeared, causing
> > udev breakage and more.
> > 
> > The cause of this is that the /sys/.../power subdirectory is now only created
> > when CONFIG_PM_SLEEP is set, however, it should be created whenever CONFIG_PM
> > is set to handle the above situation. The following patch fixes the
> > regression.
> > 
> 
> Your patch is for 2.6.24-rc2 and 2.6.23, afacit.  It needed some work to
> apply on Greg's tree because the new pm_sleep_lock() and pm_sleep_unlock()
> went and copied the same bug as you've fixed here.
> 
> I guess the right thing to do is to apply your patch as-is to 2.6.24-rcX
> and to 2.6.23.x.  I can't really do that because doing so would wreck my
> copy of Greg's tree.
> 
> 
> So I'll run with the below (I think it's right) and will let Greg sort it
> out ;)

Yeah, I'll sort it all out :)

thanks,

greg k-h
