From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 01/47] kernel: Add support for power-off handler call
 chain
Date: Tue, 28 Oct 2014 18:49:45 +0100
Message-ID: <20141028174945.GA11668@amd>
References: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
 <1414425354-10359-2-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42264 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbaJ1Rtr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Oct 2014 13:49:47 -0400
Content-Disposition: inline
In-Reply-To: <1414425354-10359-2-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Alexander Graf <agraf@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Stuebner <heiko@sntech.de>, Lee Jones <lee.jones@linaro.org>, Len Brown <len.brown@intel.com>, Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Romain Perier <romain.perier@gmail.com>

On Mon 2014-10-27 08:55:08, Guenter Roeck wrote:
> Various drivers implement architecture and/or device specific means to
> power off the system.  For the most part, those drivers set the global
> variable pm_power_off to point to a function within the driver.

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
