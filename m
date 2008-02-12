From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI suspend: Execute _WAK with the right
	argument
Date: Wed, 13 Feb 2008 00:49:14 +0100
Message-ID: <200802130049.15132.rjw__44982.5426484042$1202860407$gmane$org@sisk.pl>
References: <200802130032.17636.rjw@sisk.pl> <20080212234513.GA2564@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080212234513.GA2564@elf.ucw.cz>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Mirco Tischler <mt-ml@gmx.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 13 of February 2008, Pavel Machek wrote:
> On Wed 2008-02-13 00:32:16, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > The _WAK global ACPI control method has to be called with the
> > argument representing the sleep state being exited.  Make it happen.
> > 
> > Special thanks to Mirco Tischler <mt-ml@gmx.de> for reporting the
> > problem and debugging.
> > 
> > Reported-by: Mirco Tischler <mt-ml@gmx.de>
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> ACK. AFAICT this is 2.6.25 material.

Sure, it certainly is.  The bug has been breaking suspend on people's boxes
already.

Thanks,
Rafael


> > ---
> >  drivers/acpi/hardware/hwsleep.c |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > Index: linux-2.6/drivers/acpi/hardware/hwsleep.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/acpi/hardware/hwsleep.c
> > +++ linux-2.6/drivers/acpi/hardware/hwsleep.c
> > @@ -616,6 +616,7 @@ acpi_status acpi_leave_sleep_state(u8 sl
> >  		return_ACPI_STATUS(status);
> >  	}
> >  
> > +	arg.integer.value = sleep_state;
> >  	status = acpi_evaluate_object(NULL, METHOD_NAME__WAK, &arg_list, NULL);
> >  	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
> >  		ACPI_EXCEPTION((AE_INFO, status, "During Method _WAK"));
> 
