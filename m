From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] saa7134: Add pm_qos_request to fix video corruption
Date: Tue, 30 Oct 2012 11:11:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1210301109580.1363-100000@iolanthe.rowland.org>
References: <2614655.PC7gBWDYxH@f17simon>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <2614655.PC7gBWDYxH@f17simon>
Sender: linux-media-owner@vger.kernel.org
To: Simon Farnsworth <simon.farnsworth@onelan.co.uk>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>, Andy Walls <awalls@md.metrocast.net>, linux-media@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 29 Oct 2012, Simon Farnsworth wrote:

> On Monday 29 October 2012 13:44:45 Mauro Carvalho Chehab wrote:
> > Thanks for digging into it and getting more data. Do you know if this change
> > it also needed with USB devices that do DMA (isoc and/or bulk)? Or the USB
> > core already handles that?
> > 
> I'm not a huge expert - the linux-pm list (cc'd) will have people around who
> know more.
> 
> If I've understood correctly, though, the USB core should take care of pm_qos
> requests if they're needed for the hardware; remember that if the HCD has
> enough buffering, there's no need for a pm_qos request.

The USB core is not PM-QOS aware.  It relies on the PM core to tell it 
when devices may safely be runtime-suspended.

Alan Stern
