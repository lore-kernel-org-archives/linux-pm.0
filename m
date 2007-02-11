From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Re: NAK new drivers without proper power management?
Date: Sun, 11 Feb 2007 13:19:57 +0000
Message-ID: <20070211131957.GA6039@srcf.ucam.org>
References: <fa.xSKPgY66Q+DPCZ1pszFFfdrJ0To@ifi.uio.no> <200702101130.44471.rjw@sisk.pl> <Pine.LNX.4.64.0702101231281.20138@iabervon.org> <200702102050.28218.rjw@sisk.pl> <20070211065404.GA943@1wt.eu> <20070211121339.GB4204@srcf.ucam.org> <20070211130943.GA1868@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752674AbXBKNUZ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070211130943.GA1868@1wt.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Willy Tarreau <w@1wt.eu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Daniel Barkalow <barkalow@iabervon.org>, nigel@nigel.suspend2.net, Robert Hancock <hancockr@shaw.ca>, linux-kernel <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Feb 11, 2007 at 02:09:43PM +0100, Willy Tarreau wrote:

> Then change the PCI layer to do the basic PM only for known compatible
> drivers, and modify only the known-compatible drivers to mark them
> explicitly compatible. IMHO, it generally is a bad idea to require that
> any driver explicitly states what it *does not* support. It's the reason
> why users encounter problem on new features with old drivers. For instance,
> do you know if the old ISA NE2000 driver breaks suspend ? I don't know,
> but I would at least expect it not to support it by default. It's best
> to announce what *is* supported and consider everything unimplemented
> otherwise explicitly stated.

This ignores the reality of the situation, which is that many drivers 
support suspend and resume despite the lack of any explicit 
implementation. Changing things so they're flagged as broken when 
they're not would be a regression.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
