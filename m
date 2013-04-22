From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv2 0/3] thermal: lookup temperature
Date: Mon, 22 Apr 2013 13:06:48 +0200
Message-ID: <20130422110647.GB24710@amd.pavel.ucw.cz>
References: <1365027197-2793-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57714 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803Ab3DVLGt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Apr 2013 07:06:49 -0400
Content-Disposition: inline
In-Reply-To: <1365027197-2793-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, durgadoss.r@intel.com

Hi!

> Here is V2 of temperature lookup helper function. This has been
> split into two API as suggested on V1.
> 
> The usage of it is exemplified on patch 03.
> 
> 
> Eduardo Valentin (3):
>   thermal: introduce thermal_zone_get_zone_by_name helper function

Is the function name maybe a bit long? Perhaps using tz_ prefix
instead of "thermal_zone_" would help? or thermal_get_by_name? tz_get_by_name?

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
