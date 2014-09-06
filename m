From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / sysfs: avoid shadowing variables
Date: Sat, 6 Sep 2014 22:12:44 +0200
Message-ID: <20140906201244.GA12554@amd>
References: <1409902505-31549-1-git-send-email-johannes@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35885 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbaIFUMr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 6 Sep 2014 16:12:47 -0400
Content-Disposition: inline
In-Reply-To: <1409902505-31549-1-git-send-email-johannes@sipsolutions.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>

On Fri 2014-09-05 09:35:05, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> The global variable "enabled" is shadowed in a number of
> functions in this file, rename it to "_enabled" to avoid
> that. For consistency, also rename "disabled" and move
> them both into the #ifdef where they're needed.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
