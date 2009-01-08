From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Regression] USB wakeup problem on Toshiba Portege
	R500
Date: Thu, 8 Jan 2009 18:03:48 +0100
Message-ID: <200901081803.49632.rjw__44561.5411540077$1231434489$gmane$org@sisk.pl>
References: <200901080835.39639.rjw@sisk.pl> <200901081736.12926.rjw@sisk.pl>
	<200901081748.58962.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200901081748.58962.oliver@neukum.org>
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
To: Oliver Neukum <oliver@neukum.org>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 08 January 2009, Oliver Neukum wrote:
> Am Thursday 08 January 2009 17:36:12 schrieb Rafael J. Wysocki:
> > > We do support remote wakeup from PS2 keyboards. So you might argue we
> > > should do the same for USB HID devices.
> > 
> > Well, _I_ can live with a few 'echo disabled > /sys/devices/.../power/wakeup'
> > lines in my init scripts, but I'm afraid we're going to get many problem
> > reports related to this.  This means people will likely lose time on trying to
> > debug this problem and someone will have to handle the reports.  Are you
> > volunteering to do that?
> 
> You are making a very persuasive argument for reverting it.
> But what about laptops that only have a USB keyboard?

Well, up to and including 2.6.28 they needed to echo 'enable' to the USB
controllers' /sys/devices/.../power/wakeup files, so if the patch is reverted,
they won't be worse off than they were day before yestarday. :-)

Perhaps we can choose the default depending on whether or not any HID devices
are attached to given controller?

Thanks,
Rafael
