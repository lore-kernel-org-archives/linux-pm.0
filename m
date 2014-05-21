From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC 2/2] PM / OPP: extend DT parsing to allow voltage ranges
Date: Wed, 21 May 2014 15:49:31 +0200
Message-ID: <20140521134931.GB15936@amd.pavel.ucw.cz>
References: <1400596060-5330-1-git-send-email-l.stach@pengutronix.de>
 <1400596060-5330-3-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48910 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbaEUNtd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 May 2014 09:49:33 -0400
Content-Disposition: inline
In-Reply-To: <1400596060-5330-3-git-send-email-l.stach@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nishanth Menon <nm@ti.com>

On Tue 2014-05-20 16:27:40, Lucas Stach wrote:
> Following the introduction of voltage ranges into OPP
> we need a way to encode them in the device tree in a
> similar fashion to the non-ranged versions.
> 
> To keep compatibility with old DTs the parsing function
> is changed to understand both versions.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Reviewed-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
