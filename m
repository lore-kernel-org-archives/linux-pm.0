From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [patch/rft 2.6.17-rc2] swsusp resume must not device_suspend()
Date: Thu, 27 Apr 2006 12:41:28 -0700
Message-ID: <200604271241.28944.david-b@pacbell.net>
References: <200604241429.52022.david-b@pacbell.net> <20060427012231.GB26351@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060427012231.GB26351@linux.intel.com>
Content-Disposition: inline
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: Patrick Mochel <mochel@linux.intel.com>
Cc: linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 26 April 2006 6:22 pm, Patrick Mochel wrote:
> On Mon, Apr 24, 2006 at 02:29:51PM -0700, David Brownell wrote:
> 
> > I recently observed this myself and tracked down one problem.  The solution
> > involves what kexec() does in much the same situation:  before starting a
> > new kernel, most hardware needs to be reset.  Today, swsusp will suspend it
> > instead, which is the root cause of the problem.
> 
> I'm not sure that is a good thing to do for a lot of video chipsets on x86 
> platforms. For many, we do not have a way to reinitialize them from scratch,
> so if we do a reset on them then we shoot ourselves in the foot. 

I was waiting for someone else to bring up video; it wasn't exactly the
elephant-in-the-room-that-nobody-wants-to-talk-about, but it was clearly
a trouble spot missing from the discussion.

Agreed that it'd be good not to reset video hardware.  Of the handful of
drivers that try to do anything specific with FREEZE, Mr. Grep reports
that we have USB, IDE ... and a bunch of video drivers.


> It's very difficult to know what every single device needs, so we should just
> be honest with the drivers - tell them exactly what we're about to do - and
> let them handle it as appropriate..

There does seem to be agreement that the current FREEE invocation is not
sufficient.  I'm looking at a slightly different solution now ... one which
unfortunately involves changing drivers, but can indeed allow swsusp resume
paths to do the right thing (instead of what it does now).

- Dave


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
