From: "Alexey Starikovskiy" <aystarik@gmail.com>
Subject: Re: [RFC][PATCH -mm 1/2] swsusp: Remove platform callbacks
	from restore code
Date: Wed, 9 May 2007 21:30:42 +0400
Message-ID: <8f8ff01d0705091030t767be98cwb1d2d96e1f9bdbcd__155.038576531474$1178732742$gmane$org@mail.gmail.com>
References: <200705052227.14265.rjw@sisk.pl> <200705091520.23052.rjw@sisk.pl>
	<8f8ff01d0705090634j1c0af8d1m5f7d2c787721a239@mail.gmail.com>
	<200705091855.01019.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705091855.01019.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, suspend-devel@lists.sourceforge.net, Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Yes, something like that should do...
I'd prefer not to call ACPI functions from outside of drivers/acpi,
but this could be cleaned later.

On 5/9/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Wednesday, 9 May 2007 15:34, Alexey Starikovskiy wrote:
> > we needed to call pm_prepare() on boot kernel only to disable GPEs to
> > resolve 7887. It will also blink the LEDs during the resume image
> > load, but it's possible to live without it.
> > If you drop call to pm_prepare(), we still need to disable GPEs, so
> > they will not fire during image switch. So if we disable GPE in
> > suspend() method of EC it will work as soon as there are no other so
> > much active GPEs at boot time...
>
> Okay, I just wanted to clarify.
>
> In that case, I think, we should add a special callback to disable the GPEs
> in the restore code path (before we restore the image).
>
> I also think that it would be sufficient if this callback only executed the
> following loop:
>
>
>         status = acpi_hw_disable_all_gpes();
>         if (ACPI_FAILURE(status)) {
>                 return_ACPI_STATUS(status);
>         }
>
> and it should be called right before disable_nonboot_cpus().
>
> Is that correct?
>
> Now, assumig that it's correct, we'll need a complementary callback to be
> executed in the restore error code paths, right after enable_nonboot_cpus(),
> to enable the GPEs if there's an error during the restore.  I think it might
> contain the following code:
>
>         status = acpi_hw_enable_all_runtime_gpes();
>         if (ACPI_FAILURE(status)) {
>                 return_ACPI_STATUS(status);
>         }
>
>
> Greetings,
> Rafael
>
>
> > On 5/9/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > On Wednesday, 9 May 2007 13:59, Alexey Starikovskiy wrote:
> > > > This patch will disable EC GPE, which seems to be major problem.
> > >
> > > Could you please explain to me why you think so?
> > >
> > > Greetings,
> > > Rafael
> > >
> >
> >
>
> --
> If you don't have the time to read,
> you don't have the time or the tools to write.
>                 - Stephen King
>
>
