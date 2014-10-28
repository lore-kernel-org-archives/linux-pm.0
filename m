From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 47/47] kernel: Remove pm_power_off
Date: Tue, 28 Oct 2014 18:50:36 +0100
Message-ID: <20141028175036.GC11668@amd>
References: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
 <1414425354-10359-48-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414425354-10359-48-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Mon 2014-10-27 08:55:54, Guenter Roeck wrote:
> No users of pm_power_off are left, so it is safe to remove the function.
> 
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
