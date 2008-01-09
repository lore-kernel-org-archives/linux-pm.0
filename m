From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: USB D3 vs system S3
Date: Wed, 9 Jan 2008 00:09:21 +0000
Message-ID: <200801090009.22447.carlos@strangeworlds.co.uk>
References: <200801081547.00473.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200801081547.00473.lenb@kernel.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Len Brown <lenb@kernel.org>
Cc: USB development list <linux-usb-devel@lists.sourceforge.net>, gregkh@suse.de, Linux-pm mailing list <linux-pm@lists.osdl.org>, David Brownell <david-b@pacbell.net>, linux-acpi@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-pm@vger.kernel.org

On Tuesday 08 January 2008 20:47:00 Len Brown wrote:
> FYI,
> I think we may have an issue here where the entire Linux suspend order
> is being proposed to change, when in fact the underlying issue
> may really be that USB is in D3 on S3 for this box when it is
> not supposed to be deeper below D1.
>
> http://bugzilla.kernel.org/show_bug.cgi?id=9528

I respectfully disagree. The USB device that exhibits this behaviour (USB2, 
the device that gets bound to ehci-hcd) is not the offender - the system will 
suspend and resume just fine even after Linux has put it into D3.

USB0 (the device that gets bound to ohci-hcd), does not have this requirement 
that it can be only put into D1 when going to S3 - the DSDT here says it's 
just fine to put this device into D3 when we advertise XP compatibility.

As I pointed out in the bug:

1) The ACPI suspend ordering is still wrong for suspend on ACPI 1.0 systems

2) Based on poking around in Vista, it may also be required to disable 
autosuspend for OHCI on CK804 (nForce 4), since Vista here apparently does 
not enable USB autosuspend on the USB hubs on this board (yet enabling 
autosuspend is supposedly the default Vista behaviour, and I've certainly 
never touched the USB settings in Vista).

Given we have two different BIOS's from different manufacturers for the same 
chipset, that both have a similar SMI trap, and are both breaking here, I 
wonder if this is a known problem with the reference nVidia BIOS; so Windows 
will not put USB devices into D3 early on this chipset, to ensure that USB0 
is not in a low power state before _PTS() is called (unfortunately, on point 
2, I don't have enough to back it up either way, besides my own observations 
here).

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
