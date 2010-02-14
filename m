From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Two problems with system sleep
Date: Sun, 14 Feb 2010 22:47:11 +0100
Message-ID: <201002142247.11094.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1002141336040.1365-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1002141336040.1365-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Alan <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Sunday 14 February 2010, Alan Stern wrote:
> On Sat, 13 Feb 2010, Rafael J. Wysocki wrote:
> 
> > > The bigger problem is that with a normal sleep ("echo none >pm_test"),
> > > the system doesn't wake up.  Pressing a key or a mouse button does
> > > nothing.  Pressing the power button causes the machine to start up
> > > again, but the screen remains blank and there's no response to network
> > > pings.
> > > 
> > > This was with more or less standard 2.6.33-rc6 (Greg KH's patch set was 
> > > applied but none of your PM patches).  The motherboard is an Intel 
> > > ICH5 with a 32-bit CPU.  Any ideas on ways to approach this?
> > 
> > That depends on the graphics adapter.  Is it Intel or AMD?
> 
> $ lspci -s 2.0
> 00:02.0 VGA compatible controller: Intel Corporation 82865G Integrated Graphics Controller (rev 02)

Well, that is supposed to work.  Do you have KMS turned on?

> Do you need any more information than that?

Is the problem reproducible with init=/bin/bash vga=0?

Rafael
