From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] PM: use pm_op methods for device types
Date: Thu, 25 Sep 2008 15:06:35 -0700
Message-ID: <20080925220635.GA12175__7241.85144431448$1222380722$gmane$org@kroah.com>
References: <Pine.LNX.4.44L0.0809251704580.2181-100000@iolanthe.rowland.org>
	<200809252327.03305.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200809252327.03305.rjw@sisk.pl>
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
Cc: Jiri Slaby <jirislaby@gmail.com>, USB list <linux-usb@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 25, 2008 at 11:27:02PM +0200, Rafael J. Wysocki wrote:
> On Thursday, 25 of September 2008, Alan Stern wrote:
> > This patch (as1141) adds code to use the device type's pm_op methods,
> > if they are defined.  It fixes a regression in the USB PM code; the
> > various suspend and resume methods are defined in the device type
> > rather than in the bus, because USB devices have to be handled
> > differently from USB interfaces.  Without the patch, those methods
> > never get called.
> > 
> > The patch also fixes a couple of spelling errors.
> 
> Hm, these changes are not needed in the current mainline, so there's a patch
> in -next that removes the code added by this patch.
> 
> It might be better to find that patch and drop it instead, IMO.

I agree, I think we would have seen more bugs if mainline can't suspend
with a USB device attached, right?

confused,

greg k-h
