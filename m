From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v1 0/3] make kurobox-pro be able to shutdown after
 device-tree migration
Date: Wed, 7 Dec 2016 19:04:51 +0100
Message-ID: <20161207180451.GG26852@lunn.ch>
References: <20161206173420.GB18817@lunn.ch>
 <20161207172415.9776-1-rogershimizu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:48203 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752441AbcLGSFx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Dec 2016 13:05:53 -0500
Content-Disposition: inline
In-Reply-To: <20161207172415.9776-1-rogershimizu@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Roger Shimizu <rogershimizu@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Ryan Tandy <ryan@nardis.ca>, Martin Michlmayr <tbm@cyrius.com>, Sylver Bruneau <sylver.bruneau@googlemail.com>, Herbert Valerio Riedel <hvr@gnu.org>

> Dear Andrew,
> 
> Thanks for your review!
> 
> I split off most of kurobox-pro releated code into separated files.
> Hope you can accept this series.

Hi Roger

I still think it should be a separate driver. The 128 lines of
kuroboxpro-common.c is only slightly smaller than the unmodified
driver.

What code are you actually sharing? The probe and remove functions,
which is mostly boiler plate, the same in all driver, and the baud
rate generation. So there is very little actually common and re-used.

	   Andrew
