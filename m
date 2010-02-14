From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Two problems with system sleep
Date: Sun, 14 Feb 2010 13:36:57 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1002141336040.1365-100000@iolanthe.rowland.org>
References: <201002130113.01434.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002130113.01434.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Alan <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Sat, 13 Feb 2010, Rafael J. Wysocki wrote:

> > The bigger problem is that with a normal sleep ("echo none >pm_test"),
> > the system doesn't wake up.  Pressing a key or a mouse button does
> > nothing.  Pressing the power button causes the machine to start up
> > again, but the screen remains blank and there's no response to network
> > pings.
> > 
> > This was with more or less standard 2.6.33-rc6 (Greg KH's patch set was 
> > applied but none of your PM patches).  The motherboard is an Intel 
> > ICH5 with a 32-bit CPU.  Any ideas on ways to approach this?
> 
> That depends on the graphics adapter.  Is it Intel or AMD?

$ lspci -s 2.0
00:02.0 VGA compatible controller: Intel Corporation 82865G Integrated Graphics Controller (rev 02)

Do you need any more information than that?

Alan Stern
