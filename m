From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [linux-pm] Re: ehci_hcd causes box to
	resume	immediately after suspend to RAM
Date: Tue, 25 Sep 2007 15:01:03 +1000
Message-ID: <1190696463.31978.8.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0706141823220.5119-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0706141823220.5119-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm <linux-pm@lists.osdl.org>, USB development list <linux-usb-devel@lists.sourceforge.net>
List-Id: linux-pm@vger.kernel.org


> That's odd.  Where could these overcurrent changes be coming from?  
> And how come they don't show up on ports 1 and 2?
> 
> There's an excellent chance that they are responsible for your 
> immediate resumes.

I've seen quirks in Apple drivers a while ago where they tried to avoid
suspending some of the RH ports... possibly bcs they aren't connected to
anything and trying to suspend them does bad things. I wonder if maybe
ACPI might carry similar kind of informations...

Ben.



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
