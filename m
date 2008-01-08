From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: USB D3 vs system S3
Date: Tue, 8 Jan 2008 22:09:10 +0100
Message-ID: <200801082209.11506.rjw@sisk.pl>
References: <200801081547.00473.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200801081547.00473.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, David Brownell <david-b@pacbell.net>, gregkh@suse.de, linux-acpi@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.osdl.org>, USB development list <linux-usb-devel@lists.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 8 of January 2008, Len Brown wrote:
> FYI,
> I think we may have an issue here where the entire Linux suspend order
> is being proposed to change, when in fact the underlying issue
> may really be that USB is in D3 on S3 for this box when it is
> not supposed to be deeper below D1.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=9528

Bug #9528 is not the only test case, though.

Please have a look at this thread:
http://marc.info/?t=119945995300002&r=1&w=2

Thanks,
Rafael
