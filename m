From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ACPI: Make pnpacpi_suspend handle errors
Date: Thu, 16 Aug 2007 10:41:02 +0200
Message-ID: <20070816084102.GC1283@atrey.karlin.mff.cuni.cz>
References: <200708151523.43921.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200708151523.43921.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> pnpacpi_suspend() doesn't check the result returned by
> acpi_pm_device_sleep_state() before passing it to acpi_bus_set_power(), which
> may not be desirable.  Make it select the target power state of the device
> using its second argument if acpi_pm_device_sleep_state() fails.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Looks ok to me.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
