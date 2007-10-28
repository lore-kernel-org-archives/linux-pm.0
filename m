From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: USB_SUSPEND needs SUSPEND?
Date: Sun, 28 Oct 2007 19:48:36 +0100
Message-ID: <200710281948.37588.rjw__35262.2427781627$1193596409$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0710281245130.28311-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0710281245130.28311-100000@netrider.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Martin <oliver.martin@student.tuwien.ac.at>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, USB development list <linux-usb-devel@lists.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

On Sunday, 28 October 2007 17:50, Alan Stern wrote:
> On Sun, 28 Oct 2007, Rafael J. Wysocki wrote:
> 
> > On Sunday, 28 October 2007 02:00, Oliver Martin wrote:
> > > Hello,
> > > 
> > > it seems that there is some dependency missing for CONFIG_USB_SUSPEND.
> > > When I compile a kernel without CONFIG_SUSPEND, USB suspend doesn't work
> > > (or at least doesn't expose its interface to userspace).
> > > /sys/bus/usb/devices/.../power doesn't exist, but it is there when I
> > > enable CONFIG_SUSPEND. So should CONFIG_USB_SUSPEND depend on
> > > CONFIG_SUSPEND (or something selected by CONFIG_SUSPEND)?
> > > 
> > > diff between the two configs follows, full config and dmesg for both
> > > kernels is available at http://stud4.tuwien.ac.at/~e0626486/usb_suspend/
> > > (though the dmesg diff doesn't seem to be all that interesting).
> 
> Actually I think the problem is the other way around.  /sys/.../power 
> should exist whenever CONFIG_PM is defined, not just when 
> CONFIG_SUSPEND is enabled.

Agreed.
