From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: use pm_op methods for device types
Date: Fri, 26 Sep 2008 09:56:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0809260948580.2395-100000__5355.6902603761$1222437669$gmane$org@iolanthe.rowland.org>
References: <20080925220635.GA12175@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080925220635.GA12175@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: USB list <linux-usb@vger.kernel.org>, Jiri Slaby <jirislaby@gmail.com>, Kay Sievers <kay.sievers@vrfy.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hannes Reinecke <hare@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 25 Sep 2008, Greg KH wrote:

> On Thu, Sep 25, 2008 at 11:27:02PM +0200, Rafael J. Wysocki wrote:
> > On Thursday, 25 of September 2008, Alan Stern wrote:
> > > This patch (as1141) adds code to use the device type's pm_op methods,
> > > if they are defined.  It fixes a regression in the USB PM code; the
> > > various suspend and resume methods are defined in the device type
> > > rather than in the bus, because USB devices have to be handled
> > > differently from USB interfaces.  Without the patch, those methods
> > > never get called.
> > > 
> > > The patch also fixes a couple of spelling errors.
> > 
> > Hm, these changes are not needed in the current mainline, so there's a patch
> > in -next that removes the code added by this patch.
> > 
> > It might be better to find that patch and drop it instead, IMO.
> 
> I agree, I think we would have seen more bugs if mainline can't suspend
> with a USB device attached, right?
> 
> confused,

Okay, I was confused too.  Looking more closely, it's apparent that 
mainline is okay and the problem was introduced by Hannes Reinecke's 

driver-core-remove-suspend-resume-callbacks-for-device-type.patch

which states that the suspend/resume callbacks in struct device_type
are unused.  It may be true that the legacy suspend/resume methods are
unused, but the new pm_ops methods definitely are used.

Therefore part or all of Hannes patch should be reverted.  And the 
mainline is okay as it stands.

Alan Stern
