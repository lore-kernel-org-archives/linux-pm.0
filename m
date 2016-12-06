From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 0/3] make kurobox-pro be able to shutdown after
 device-tree migration
Date: Tue, 6 Dec 2016 18:34:20 +0100
Message-ID: <20161206173420.GB18817@lunn.ch>
References: <20161205124528.2999-1-rogershimizu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:44441 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751618AbcLFRfD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Dec 2016 12:35:03 -0500
Content-Disposition: inline
In-Reply-To: <20161205124528.2999-1-rogershimizu@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Roger Shimizu <rogershimizu@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Ryan Tandy <ryan@nardis.ca>, Martin Michlmayr <tbm@cyrius.com>, Sylver Bruneau <sylver.bruneau@googlemail.com>, Herbert Valerio Riedel <hvr@gnu.org>

On Mon, Dec 05, 2016 at 09:45:25PM +0900, Roger Shimizu wrote:
> Dear Sebastian,
> 
> Kurobox-Pro (and variants) need more commands sending to UART1 to shutdown.
> So here I make this patch series to let current qnap-poweroff implementation
> be able to handle such case.
> 
> I already tested this change on Kurobox-Pro and Linkstation LS-GL devices,
> with a modified device-tree file. (Previous device-tree of kurobox-pro invokes
> restart-poweroff, so it simply restarts.)
> 
> Thank you and look forward to your feedback!

Hi Roger

You are adding a lot of new code here, and not actually reusing much
of that is there, but adding a lot of complexity to what is a simple
driver.

I would prefer if you actually write a new driver which just supports
Kurobox.

Thanks
	Andrew
