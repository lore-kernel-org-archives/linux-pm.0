From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: resume bug
Date: Wed, 1 Apr 2015 13:38:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1504011335020.1420-100000@iolanthe.rowland.org>
References: <551C116F.2000403@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:59339 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751210AbbDARiF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Apr 2015 13:38:05 -0400
In-Reply-To: <551C116F.2000403@web.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "W.Pelser" <w.pelser@web.de>
Cc: linux-pm@vger.kernel.org

On Wed, 1 Apr 2015, W.Pelser wrote:

> Bug ID: 94861
>             Summary: After resume from hibernate/sleep USB-DVBT-adapter
>                       does not work
> 
> Kernel 3.19.x and 4.0rcx
> 
> After boot:
>    strace -f -o /tmp/strace.out lsdvb .... :
>      .
>      .
>      2114  open("/dev/dvb/adapter0/frontend0", O_RDWR|O_NONBLOCK) = 6
>      .
>      .
> 
> 
> After resume:
>    strace -f -o /tmp/strace.out lsdvb .... :
>       .
>       .
>      3848  open("/dev/dvb/adapter0/frontend0", O_RDWR|O_NONBLOCK) = -1 
> ENODEV (No  such device)
>       .
>       .

If you are able to build and test your own kernels, you can try using 
git bisect to find out which change between the 3.18 and 3.19 kernels 
caused this problem.

This really ought to be discussed on the linux-media mailing list, 
because it is a regression in the dvb-usb driver.

Alan Stern

