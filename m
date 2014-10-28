From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 03/47] hibernate: Call have_kernel_power_off instead
 of checking pm_power_off
Date: Tue, 28 Oct 2014 18:50:11 +0100
Message-ID: <20141028175011.GB11668@amd>
References: <1414425354-10359-1-git-send-email-linux@roeck-us.net>
 <1414425354-10359-4-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414425354-10359-4-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Mon 2014-10-27 08:55:10, Guenter Roeck wrote:
> Power-off handlers may now be installed with register_power_off_handler.
> Use the new API function have_kernel_power_off to determine if a power-off
> handler has been installed.
> 
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
