From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH][v2] PM / sleep: Increase default DPM watchdog timeout to
 120
Date: Fri, 19 Aug 2016 09:19:55 +0200
Message-ID: <20160819071955.GA2450@amd>
References: <1471581443-22184-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1471581443-22184-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri 2016-08-19 12:37:23, Chen Yu wrote:
> Recently we have a new report that, the harddisk can not
> resume on time due to firmware issues, and got a kernel
> panic because of DPM watchdog timeout. So adjust the
> default timeout from 60 to 120 to survive on this platform,
> and make DPM_WATCHDOG depending on EXPERT.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=117971

Acked-by: Pavel Machek <pavel@ucw.cz>

Thanks!
								Pavel
								
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
