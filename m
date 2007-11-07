From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] create /sys/.../power when CONFIG_PM is set
Date: Wed, 7 Nov 2007 11:45:14 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0711071143200.4444-100000__899.116232949559$1194453982$gmane$org@iolanthe.rowland.org>
References: <20071107101043.2E64C9D4ECC@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071107101043.2E64C9D4ECC@zog.reactivated.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Drake <dsd@gentoo.org>
Cc: linux-hotplug-devel@lists.sourceforge.net, kay.sievers@vrfy.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, oneukum@suse.de
List-Id: linux-pm@vger.kernel.org

On Wed, 7 Nov 2007, Daniel Drake wrote:

> The CONFIG_SUSPEND changes in 2.6.23 caused a regression under certain
> configuration conditions (SUSPEND=n, USB_AUTOSUSPEND=y) where all USB device
> attributes in sysfs (idVendor, idProduct, ...) silently disappeared, causing
> udev breakage and more.
> 
> The cause of this is that the /sys/.../power subdirectory is now only created
> when CONFIG_PM_SLEEP is set, however, it should be created whenever CONFIG_PM
> is set to handle the above situation. The following patch fixes the
> regression.
> 
> Signed-off-by: Daniel Drake <dsd@gentoo.org>

I haven't tried applying this, but it looks okay to me.  There may be 
some conflict with other changes already merged in the PM core.

Alan Stern
