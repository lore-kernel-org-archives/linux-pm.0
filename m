From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3] PM / sleep: prohibit devices probing during
 suspend/hibernation
Date: Sun, 15 Nov 2015 16:46:12 +0100
Message-ID: <20151115154612.GA20981@amd>
References: <1447148554-18401-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55542 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbbKOPqQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 15 Nov 2015 10:46:16 -0500
Content-Disposition: inline
In-Reply-To: <1447148554-18401-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>

On Tue 2015-11-10 11:42:34, Grygorii Strashko wrote:
> It is unsafe [1] if probing of devices will happen during suspend or
> hibernation and system behavior will be unpredictable in this case.
> So, let's prohibit device's probing in dpm_prepare() and defer their
> probing instead. The normal behavior will be restored in
> dpm_complete().
> 
> This patch introduces new DD core APIs:
>  device_block_probing()
>    It will disable probing of devices and defer their probes instead.
>  device_unblock_probing()
>    It will restore normal behavior and trigger re-probing of deferred
>    devices.
> 
> [1] https://lkml.org/lkml/2015/9/11/554
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
