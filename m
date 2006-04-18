From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [linux-pm] Behavior of PCMCIA based HCD in the event of SUSPEND
Date: Tue, 18 Apr 2006 16:38:24 +0200
Message-ID: <20060418143824.GA8441@isilmar.linta.de>
References: <05B7784238A51247A0A9FB4B348CECAE019BAAF3@PNE-HJN-MBX01.wipro.com> <Pine.LNX.4.44L0.0604180940070.4972-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0604180940070.4972-100000@iolanthe.rowland.org>
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: kaustav.majumdar@wipro.com, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 18, 2006 at 09:45:50AM -0400, Alan Stern wrote:
> On Tue, 18 Apr 2006 kaustav.majumdar@wipro.com wrote:
> > Also the PCMCIA subsystem's behavior is to power off the socket
> > irrespective of whether the PCMCIA client driver has successfully
> > handled the SUSPEND event or not.
> 
> I don't know how the PCMCIA subsystem works.  If it behaves the way you 
> described then it is broken and should be fixed.

At least with latest 2.6.17-rc1, if the PCMCIA driver returns an error in
its suspend function, this error is passed to the PM layer which should stop
the suspend-to-?-path. If you're calling "pccardctl suspend", the PCMCIA
layer itself checks for this error AFAICS.

	Dominik


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
