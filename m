From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch/rft 2.6.17-rc2] swsusp resume must not
	device_suspend()
Date: Wed, 26 Apr 2006 18:09:08 +0200
Message-ID: <200604261809.08982.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0604261132340.5361-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0604261132340.5361-100000@iolanthe.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Brownell <david-b@pacbell.net>, Nigel Cunningham <nigel@suspend2.net>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 26 April 2006 17:38, Alan Stern wrote:
> On Wed, 26 Apr 2006, Rafael J. Wysocki wrote:
> 
> > > So under these circumstances, how does it hurt anything to reset the 
> > > resume device rather than to freeze it?
> > 
> > It just shouldn't be necessary.  Actually I think the resume device shouldn't
> > be frozen too.
>
> Well, you wouldn't want it doing DMA to unknown memory areas while you're
> trying to place the image data in those same areas, would you?  And when
> the image is reactivated, you wouldn't want the device generating
> interrupt requests while its driver still thinks it is suspended.  (Or if 
> it doesn't even have a driver in the image.)

I think it'll always have a driver in the image, because we use it on suspend
to save the image.  Also IMHO, theoretically, the driver need not think the
device is suspended.

> And don't say that no resume device would ever do DMA or generate IRQs
> while it was idle!  What if it was a remote disk accessible via a network 
> interface?

I think at least some devices may be told not to do DMA and/or generate IRQs
without being reset or put into a low(er) power state.

Ayway, as of today, we have no infrastructure allowing us to handle resume
devices in a special way.  However, if we decide to reset all devices before
restoring the image, we'll probably make such things harder to implement
in the future.

Greetings,
Rafael
