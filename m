From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / sleep: console flush during suspend if
 no_console_suspend enabled
Date: Sat, 20 Feb 2016 18:43:04 +0100
Message-ID: <20160220174304.GB16459@amd>
References: <1450679500-6185-1-git-send-email-bbasu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34105 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759071AbcBTRnG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 20 Feb 2016 12:43:06 -0500
Content-Disposition: inline
In-Reply-To: <1450679500-6185-1-git-send-email-bbasu@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bibek Basu <bbasu@nvidia.com>
Cc: rjw@rjwysocki.net, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon 2015-12-21 12:01:40, Bibek Basu wrote:
> On multicore CPUs, sometimes debug console logs are not flushed
> if you have VT consoles also enabled. Reason being console_lock
> is taken by secondary/nonboot cpus which are  disabled as part
> of suspend.This patch flushes the console before disabling
> nonboot cpus
> 
> Signed-off-by: Bibek Basu <bbasu@nvidia.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
