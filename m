From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] create /sys/.../power when CONFIG_PM is set
Date: Wed, 7 Nov 2007 16:27:35 -0800
Message-ID: <20071108002735.GA22848__27583.684717729$1194482092$gmane$org@kroah.com>
References: <20071107101043.2E64C9D4ECC@zog.reactivated.net>
	<200711072324.56125.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200711072324.56125.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-hotplug-devel@lists.sourceforge.net, kay.sievers@vrfy.org, linux-kernel@vger.kernel.org, Daniel Drake <dsd@gentoo.org>, linux-pm@lists.linux-foundation.org, oneukum@suse.de
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 07, 2007 at 11:24:55PM +0100, Rafael J. Wysocki wrote:
> On Wednesday, 7 of November 2007, Daniel Drake wrote:
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
> > Signed-off-by: Daniel Drake <dsd@gentoo.org>
> 
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Greg, I think this patch should go through your tree?

Yes, I'll take it.  I'm at a conference until Friday, but will take it
then and then get it to Linus before 2.6.24 is out.

thanks,

greg k-h
