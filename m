From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/5] ACPI / PM: Move references to pm_flags
	into sleep.c
Date: Tue, 8 Feb 2011 15:40:33 -0800
Message-ID: <AANLkTinAZphXC=7FParFnxDPQvpB1ic=FwTe7u4Txy5o__33321.9124041081$1297208593$gmane$org@mail.gmail.com>
References: <1297081335-13631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20110208122159.GA8284@elte.hu> <201102082218.28015.rjw@sisk.pl>
	<201102082220.25240.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201102082220.25240.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, linux-embedded@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 8, 2011 at 1:20 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>
> If direct references to pm_flags are moved from bus.c to sleep.c,
> CONFIG_ACPI will not need to depend on CONFIG_PM any more.

The patch may _work_, but I really hate it. That function naming is insane:

> =A0#ifdef CONFIG_ACPI_SLEEP
> =A0#else
> +static inline bool acpi_pm_enabled(void) { return true; }

acpi_pm_enabled() returns true if ACPI_SLEEP is _not_ enabled? That's
just crazy.

... followed by more crazy:

> +bool acpi_pm_enabled(void)
> +{
> + =A0 =A0 =A0 if (!(pm_flags & PM_APM)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_flags |=3D PM_ACPI;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return true;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return false;
> +}

IOW, that function doesn't do anything _remotely_ like what the naming
indicates.

Any sane person would expect that a function called
'acpi_pm_enabled()' would return true if ACPI PM was enabled, and
false otherwise. But it's not what it does at all. Instead, what it
does is to say "if APM isn't enabled, let's enable ACPI and return
true". Except then for the non-ACPI sleep case, we just return true
regardless, which still looks damn odd, wouldn't you say?

That isn't good. Maybe it all does what you want it to do, but from a
code readability standpoint, it's just one honking big "WTF?". Please
don't do that. Call it something else. Make the naming actually follow
what the semantics are. Appropriate naming should also make it
sensible to return "true" when ACPI_SLEEP is disabled, and should make
the caller look sane.

Now, I don't know what that particular naming might be, but maybe it
would be about APM being enabled. Which is what the caller actually
seems to care about and talks about for the failure case. Maybe you
need separate functions for the "is APM enabled" case for the naming
to make sense. Hmm?

                              Linus
