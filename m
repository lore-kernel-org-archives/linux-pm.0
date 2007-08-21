From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 2/4] Hibernation: Turn on ACPI
	during restore if necessary
Date: Tue, 21 Aug 2007 16:39:01 +0200
Message-ID: <200708211639.02204.rjw@sisk.pl>
References: <200708201510.03734.rjw@sisk.pl> <200708201516.03537.rjw@sisk.pl>
	<20070821075755.GF7258@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070821075755.GF7258@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: discuss@x86-64.org, pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 21 August 2007 09:57, Pavel Machek wrote:
> Hi!
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > If the boot kernel doesn't support ACPI and ACPI is not enabled by the platform
> > boot code, it may be possible to enable ACPI after restoring the system memory
> > from a hibernation image.  Implement that.
> 
> ACK... and I guess this should go in early. It is possible to test w/o
> rest of patches, (just pass acpi=off to resume kernel, no?),

Yup, that might work.

> and it  should get lot of testing.

Why do you think so?

Rafael


> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  drivers/acpi/sleep/main.c |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > Index: linux-2.6.23-rc3/drivers/acpi/sleep/main.c
> > ===================================================================
> > --- linux-2.6.23-rc3.orig/drivers/acpi/sleep/main.c	2007-08-14 00:41:10.000000000 +0200
> > +++ linux-2.6.23-rc3/drivers/acpi/sleep/main.c	2007-08-19 20:01:05.000000000 +0200
> > @@ -240,6 +240,8 @@ static int acpi_hibernation_enter(void)
> >  
> >  static void acpi_hibernation_finish(void)
> >  {
> > +	/* If the boot kernel doesn't support ACPI, we may need to enable it */
> > +	acpi_enable();
> >  	acpi_leave_sleep_state(ACPI_STATE_S4);
> >  	acpi_disable_wakeup_device(ACPI_STATE_S4);
> >  
> 

-- 
"Premature optimization is the root of all evil." - Donald Knuth
