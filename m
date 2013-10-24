From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / hibernate: Move software_resume to
 late_initcall_sync
Date: Thu, 24 Oct 2013 16:21:49 +0200
Message-ID: <20131024142149.GA26427@xo-6d-61-c0.localdomain>
References: <1382621126-24090-1-git-send-email-Russ.Dill@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55711 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755178Ab3JXOVy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Oct 2013 10:21:54 -0400
Content-Disposition: inline
In-Reply-To: <1382621126-24090-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

Hi!

> software_resume is being called after deferred_probe_initcall in
> drivers base. If the probing of the device that contains the resume
> image is deferred, and the system has been instructed to wait for
> it to show up, this wait will occur in software_resume. This causes
> a deadlock.
> 
> Move software_resume into late_initcall_sync so that it happens
> after all the other late_initcalls.
> 
> Signed-off-by: Russ Dill <Russ.Dill@ti.com>

Acked-by: Pavel Machek <Pavel@ucw.cz>


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
