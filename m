From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM: fix kernel-doc warnings in
 drivers/base/power/main.c
Date: Mon, 28 Jul 2014 12:25:08 +0200
Message-ID: <20140728102508.GB16495@amd.pavel.ucw.cz>
References: <53D5887B.80000@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35233 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594AbaG1KZK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Jul 2014 06:25:10 -0400
Content-Disposition: inline
In-Reply-To: <53D5887B.80000@infradead.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Linux PM list <linux-pm@vger.kernel.org>

On Sun 2014-07-27 16:17:15, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix kernel-doc warnings in drivers/base/power/main.c:
> 
> Warning(..//drivers/base/power/main.c:473): No description found for parameter 'async'
> Warning(..//drivers/base/power/main.c:601): No description found for parameter 'async'
> Warning(..//drivers/base/power/main.c:1012): No description found for parameter 'async'
> Warning(..//drivers/base/power/main.c:1151): No description found for parameter 'async'
> Warning(..//drivers/base/power/main.c:1305): No description found for parameter 'info'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc:	Len Brown <len.brown@intel.com>

Acked-by: Pavel Machek <pavel@ucw.cz>
 
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
