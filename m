From: Len Brown <lenb@kernel.org>
Subject: USB D3 vs system S3
Date: Tue, 8 Jan 2008 15:47:00 -0500
Message-ID: <200801081547.00473.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
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
To: Alan Stern <stern@rowland.harvard.edu>, David Brownell <david-b@pacbell.net>, gregkh@suse.de
Cc: linux-acpi@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.osdl.org>, USB development list <linux-usb-devel@lists.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

FYI,
I think we may have an issue here where the entire Linux suspend order
is being proposed to change, when in fact the underlying issue
may really be that USB is in D3 on S3 for this box when it is
not supposed to be deeper below D1.

http://bugzilla.kernel.org/show_bug.cgi?id=9528

-Len

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
