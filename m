From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] PM / Domains: Make genpd parameter of
 pm_genpd_present() const
Date: Thu, 13 Nov 2014 15:09:13 +0100
Message-ID: <20141113140913.GC18995@amd>
References: <1415644659-2531-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59607 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932756AbaKMOJP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Nov 2014 09:09:15 -0500
Content-Disposition: inline
In-Reply-To: <1415644659-2531-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon 2014-11-10 19:37:39, Geert Uytterhoeven wrote:
> The PM domain pointed to by the genpd parameter is never modified.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Kevin Hilman <khilman@linaro.org>

Acked-by: Pavel Machek <apvel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
