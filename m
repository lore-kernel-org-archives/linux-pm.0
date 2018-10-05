From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq / CPPC: Mark acpi_ids as used
Date: Fri, 05 Oct 2018 11:51:34 +0200
Message-ID: <1561369.7cfCgrRCj6@aspire.rjw.lan>
References: <20181002223457.7564-1-natechancellor@gmail.com> <CAKwvOdnbnw-yciWkuuKMye=57qwpXDX4oPaoNUoeYvbpn-Tavw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKwvOdnbnw-yciWkuuKMye=57qwpXDX4oPaoNUoeYvbpn-Tavw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, October 3, 2018 12:40:19 AM CEST Nick Desaulniers wrote:
> On Tue, Oct 2, 2018 at 3:35 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns:
> >
> > drivers/cpufreq/cppc_cpufreq.c:431:36: warning: variable 'cppc_acpi_ids'
> > is not needed and will not be emitted [-Wunneeded-internal-declaration]
> > static const struct acpi_device_id cppc_acpi_ids[] = {
> >                                    ^
> > 1 warning generated.
> >
> > Mark the definition as used so that Clang understands we don't want this
> > warning while not inhibiting Clang's dead code elimination from removing
> > the unreferenced internal symbol when moving the data it contains to the
> > globally available symbol via MODULE_DEVICE_TABLE.
> >
> > $ nm -S drivers/cpufreq/cppc_cpufreq.o | grep acpi | tail -1
> > 0000000000000000 0000000000000040 R __mod_acpi__cppc_acpi_ids_device_table
> >
> > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/cpufreq/cppc_cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> > index 30f302149730..fd25c21cee72 100644
> > --- a/drivers/cpufreq/cppc_cpufreq.c
> > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > @@ -428,7 +428,7 @@ MODULE_LICENSE("GPL");
> >
> >  late_initcall(cppc_cpufreq_init);
> >
> > -static const struct acpi_device_id cppc_acpi_ids[] = {
> > +static const struct acpi_device_id cppc_acpi_ids[] __used = {
> >         {ACPI_PROCESSOR_DEVICE_HID, },
> >         {}
> >  };
> > --

Patch applied, thanks!
