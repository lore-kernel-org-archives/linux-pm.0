From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: [RFC 3/4] usb: Send Set SEL before enabling parent U1/U2 timeout.
Date: Mon, 22 Oct 2012 11:37:24 -0700
Message-ID: <20121022183724.GE5378@xanatos>
References: <65a95b75bc5afa7bbb844e222481044c1c4767eb.1349724947.git.sarah.a.sharp@linux.intel.com>
 <Pine.LNX.4.44L0.1210081603080.31609-100000@netrider.rowland.org>
 <20121008224735.GL18378@xanatos>
 <20121019161800.GA1493@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:14986 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755771Ab2JVShZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 22 Oct 2012 14:37:25 -0400
Content-Disposition: inline
In-Reply-To: <20121019161800.GA1493@arwen.pp.htv.fi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Fri, Oct 19, 2012 at 07:18:00PM +0300, Felipe Balbi wrote:
> Hi,
> 
> On Mon, Oct 08, 2012 at 03:47:35PM -0700, Sarah Sharp wrote:
> > On Mon, Oct 08, 2012 at 04:05:00PM -0400, Alan Stern wrote:
> > > On Mon, 8 Oct 2012, Sarah Sharp wrote:
> > > 
> > > > The Set SEL control transfer tells a device the exit latencies
> > > > associated with a device-initated U1 or U2 exit.  Since a parent hub may
> > > > initiate a transition to U1 soon after a downstream port's U1 timeout is
> > > > set, we need to make sure the device receives the Set SEL transfer
> > > > before the parent hub timeout is set.
> > > 
> > > Just a question, not a comment on the patch.  Why is "Set SEL" needed?  
> > > Doesn't the device already know its own exit latencies?  After all, the 
> > > values come from descriptors that were originally provided by the 
> > > device.
> > 
> > The device knows its own exit latency, but it doesn't know the exit
> > latencies for the path above it.  It could be directly attached to the
> > roothub (which may have a bigger exit latency than the device) or a
> > couple tiers deep in the tree.  If the device wants to be smart about
> > when it requests to come out of U1 or U2, then it needs to know the
> > whole path exit latency.
> > 
> > For example, maybe there's an interrupt endpoint on a self-powered radio
> > device.  As soon as the device doesn't have any data to send, it
> > transmits an NRDY (Not Ready) response to the request for data.  Then it
> > puts its link into U1 or U2 (or maybe the host controller does this when
> > the U1/U2 timeouts expire).
> > 
> > Later, the device starts receiving a packet.  Let's assume it takes some
> > time to process that packet.  If the device knows how long it takes to
> > wake up the link and send an ERDY to the host, it can parallelize the
> > link wakeup and the packet processing.  It doesn't want to send an ERDY
> > too soon, because the host could ask for the data before it's ready.  So
> > the device needs to know the time it takes for the link to come out of
> > U1 or U2, the time it takes for the host to process the ERDY, and the
> > time it takes for the request for data to reach the device.  That's what
> > the Set SEL request does.
> > 
> > Of course, I'm not a USB device designer, so I don't know how the Set
> > SEL command is really used.  Felipe, do we use it at all in any of the
> > Linux USB 3.0 gadget drivers?
> 
> sorry for the delay. Currently we're not using Set SEL at all, but we
> could use, eventually, to pass it to pm_qos ?!? Just a thought.

Yes, I think it could be useful to pass that information on to pm_qos.
I don't think the subsystem currently supports multiple power states
though, but Rafael would know.  On the host side, it's all custom code
to deal with the USB device U1/U2 low power states.  Only the U3 (device
suspend) is handled by the runtime PM subsystem.

Rafael is adding support for a power-off pm_qos flag, and I'm not sure
if it makes sense to add support for multiple power state flags as well.
Probably we should see how the new pm_qos flag architecture shakes out,
and then decide whether we should tackle that.

Sarah Sharp
