From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC 1/2] PM / OPP: allow to use voltage ranges
Date: Wed, 21 May 2014 15:46:52 +0200
Message-ID: <20140521134652.GA15936@amd.pavel.ucw.cz>
References: <1400596060-5330-1-git-send-email-l.stach@pengutronix.de>
 <1400596060-5330-2-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48792 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbaEUNqy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 May 2014 09:46:54 -0400
Content-Disposition: inline
In-Reply-To: <1400596060-5330-2-git-send-email-l.stach@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nishanth Menon <nm@ti.com>

On Tue 2014-05-20 16:27:39, Lucas Stach wrote:
> In many cases we don't have a strict one to one relation
> between a frequency and a voltage, but rather an operating
> frequency plus a voltage range that need to be maintained
> for this one frequency.
> 
> This patch does not change any behavior, but only expands
> the API to cope with voltage ranges.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Reviewed-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
