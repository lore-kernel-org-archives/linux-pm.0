From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 2/4] Hibernation: Turn on ACPI
	during restore if necessary
Date: Tue, 21 Aug 2007 09:57:55 +0200
Message-ID: <20070821075755.GF7258@elf.ucw.cz>
References: <200708201510.03734.rjw@sisk.pl> <200708201516.03537.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200708201516.03537.rjw@sisk.pl>
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
Cc: discuss@x86-64.org, pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

Hi!

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> If the boot kernel doesn't support ACPI and ACPI is not enabled by the platform
> boot code, it may be possible to enable ACPI after restoring the system memory
> from a hibernation image.  Implement that.

ACK... and I guess this should go in early. It is possible to test w/o
rest of patches, (just pass acpi=off to resume kernel, no?), and it
should get lot of testing.
								Pavel


> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/acpi/sleep/main.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> Index: linux-2.6.23-rc3/drivers/acpi/sleep/main.c
> ===================================================================
> --- linux-2.6.23-rc3.orig/drivers/acpi/sleep/main.c	2007-08-14 00:41:10.000000000 +0200
> +++ linux-2.6.23-rc3/drivers/acpi/sleep/main.c	2007-08-19 20:01:05.000000000 +0200
> @@ -240,6 +240,8 @@ static int acpi_hibernation_enter(void)
>  
>  static void acpi_hibernation_finish(void)
>  {
> +	/* If the boot kernel doesn't support ACPI, we may need to enable it */
> +	acpi_enable();
>  	acpi_leave_sleep_state(ACPI_STATE_S4);
>  	acpi_disable_wakeup_device(ACPI_STATE_S4);
>  

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
