From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: USB D3 vs system S3
Date: Wed, 9 Jan 2008 16:38:45 +0000
Message-ID: <200801091638.46706.carlos@strangeworlds.co.uk>
References: <Pine.LNX.4.44L0.0801091105220.4652-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0801091105220.4652-100000@iolanthe.rowland.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Len Brown <lenb@kernel.org>, David Brownell <david-b@pacbell.net>, gregkh@suse.de, linux-acpi@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.osdl.org>, USB development list <linux-usb-devel@lists.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

On Wednesday 09 January 2008 16:07:04 Alan Stern wrote:
> Currently there's no need to change anything.

Ok.

> The USB autosuspend code affects only the controller's USB interface --
> it doesn't touch the PCI side.  An autosuspended controller will remain
> in D0.  Until somebody tries writing autosuspend code for PCI
> devices...

Is this likely to happen?

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
