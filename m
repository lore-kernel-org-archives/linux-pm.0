From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] power: collie_battery: hide unused variable
Date: Sat, 30 Jan 2016 17:16:34 +0100
Message-ID: <20160130161634.GA5230@amd>
References: <1453736756-1959377-2-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453736756-1959377-2-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sebastian Reichel <sre@kernel.org>, linux-arm-kernel@lists.infradead.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon 2016-01-25 16:45:49, Arnd Bergmann wrote:
> The 'wakeup_enabled' variable in this driver is only accessed
> by the optional power management functions and we get a warning
> when they are disabled:
> 
> drivers/power/collie_battery.c:29:12: error: 'wakeup_enabled' defined but not used [-Werror=unused-variable]
> 
> This moves the definition next to the users inside the same #ifdef,
> which avoids the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
