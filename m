From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/3] pm: Introduce __pm to mark power management code
Date: Fri, 10 May 2013 12:54:46 +0200
Message-ID: <20130510105446.GA6107@amd.pavel.ucw.cz>
References: <1368119391-13837-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1368119391-13837-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, Len Brown <len.brown@intel.com>, Jingoo Han <jg1.han@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Thu 2013-05-09 10:09:48, Guenter Roeck wrote:
> The following patch series introduces a marker for power management functions
> and data. This this marker, #ifdef CONFIG_PM and #ifdef CONFIG_PM_SLEEP
> can be removed from most of the code. This ensures that the conditional code
> still compiles but is not included in the object file.

Was it compile-tested for both PM_SLEEP and !PM_SLEEP cases?

If driver wants to have pm-specific fields in its structures, this
will make it harder.

Ifdefs are ugly, and this has better compiler coverage in !PM_SLEEP
case. Good. OTOH most people are running with PM_SLEEP, so advantage
is not great...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
