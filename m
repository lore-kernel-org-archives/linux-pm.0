From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH v3] POWER/runtime: refining the rpm_suspend function
Date: Thu, 21 Jan 2016 20:32:29 +0100
Message-ID: <20160121193229.GA13448@amd>
References: <1453345731-5192-1-git-send-email-zhaoyang.huang@spreadtrum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38131 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbcAUTcb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2016 14:32:31 -0500
Content-Disposition: inline
In-Reply-To: <1453345731-5192-1-git-send-email-zhaoyang.huang@spreadtrum.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Cc: zhaoyang.huang@spreadtrum.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, len.brown@intel.com, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, serge.broslavsky@linaro.org, alex.wang@spreadtrum.com, geng.ren@spreadtrum.com


> -		goto repeat;
> +
> +		/*check expires firstly for auto suspend mode,
> +		*if not, just go ahead to the async
> +		*/

English, coding style.
								Pavel
								
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
