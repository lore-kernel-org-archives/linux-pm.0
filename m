From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4] cpufreq: intel_pstate: Reporting reasons why driver
 prematurely exit
Date: Wed, 13 Feb 2019 11:34:23 +0100
Message-ID: <CAJZ5v0jq4RGkSoO7+_uO3yDZ6g3a=Jm3YGck8Maptqff2RCkZQ@mail.gmail.com>
References: <20190212070839.25981-1-e.velu@criteo.com> <CAJZ5v0i4PFWQ5fMZ8Rh3jgu22=Me1+ArOwVW333BWa4z54Lqbg@mail.gmail.com>
 <a2f4128c-54cc-44b3-d615-977e9ed37d07@criteo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a2f4128c-54cc-44b3-d615-977e9ed37d07@criteo.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Erwan Velu <e.velu@criteo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Erwan Velu <erwanaliasr1@gmail.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "open list:INTEL PSTATE DRIVER" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 13, 2019 at 10:13 AM Erwan Velu <e.velu@criteo.com> wrote:
>
>
> Le 13/02/2019 à 00:01, Rafael J. Wysocki a écrit :
> [...]
> > Newline characters are missing in all of your messages.
>
> oops. Fixing this.
>
> > "ACPI _PSS not found\n"
>
> Done.
>
>
> >>          return true;
> >>   }
> >>
> >> @@ -2484,10 +2485,15 @@ static bool __init intel_pstate_no_acpi_pcch(void)
> >>          acpi_handle handle;
> >>
> >>          status = acpi_get_handle(NULL, "\\_SB", &handle);
> >> -       if (ACPI_FAILURE(status))
> >> +       if (ACPI_FAILURE(status)) {
> >> +               pr_debug("Cannot detect ACPI SB");
> > This is very unlikely to happen, I wouldn't bother to print anything here.
>
> As this is test is made, it means someone considered that case could exist.
>
> That's why a added a message to catch this case while debugging.
>
> I do agree that is not very likely.

So a single "no PCCH" message for this whole function should be sufficient.

> >
> >>                  return true;
> >> +       }
> >>
> >> -       return !acpi_has_method(handle, "PCCH");
> >> +       status = acpi_has_method(handle, "PCCH");
> >> +       if (!status)
> >> +               pr_debug("Cannot detect ACPI PCCH");
> > This message can be printed by the caller and, again, I would prefer
> > something like "ACPI PCCH not found".
> Fixed too.
>
> [..]
> > "ACPI _PPC not found\n"
> fixed.
> >>          return false;
> >>   }
> >>
> >> @@ -2539,8 +2546,10 @@ static bool __init intel_pstate_platform_pwr_mgmt_exists(void)
> >>          id = x86_match_cpu(intel_pstate_cpu_oob_ids);
> >>          if (id) {
> >>                  rdmsrl(MSR_MISC_PWR_MGMT, misc_pwr);
> >> -               if ( misc_pwr & (1 << 8))
> >> +               if (misc_pwr & (1 << 8)) {
> >> +                       pr_debug("MSR_MISC_PWR_MGMT reports enabled HW coordination");
> > IIRC this means that the platform is managing P-states on systems
> > without HWP, so I would print something like "P-states managed by the
> > platform\n".
>
> That's what the caller reports.
>
> I added this additional message because this function added as special
> case for this MSR setting.
>
> if intel_pstate_platform_pwr_mgmt_exists() is true, that's nice to know
> why when debugging.

I see.

> >>                          return true;
> >> +               }
> >>          }
> >>
> >>          idx = acpi_match_platform_list(plat_info);
> >> @@ -2606,22 +2615,28 @@ static int __init intel_pstate_init(void)
> >>                  }
> >>          } else {
> >>                  id = x86_match_cpu(intel_pstate_cpu_ids);
> >> -               if (!id)
> >> +               if (!id) {
> >> +                       pr_warn("CPU ID is not in the list of supported devices\n");
> > Why not pr_debug()?
> >
> > And analogously below?
>
> I'm coming from a use case where on the same hardware, changing the
> kernel changed the performance profile and impacted user's performance.
>
> I had to debug this case from a running server.
>
>  From the dmesg, one of the difference I saw was about the
> missing "Intel P-state driver initializing" message, but nothing else.
>
> The reason why the driver didn't engaged itself wasn't explicit.

And what did turn out to be the problem?

Anyway, pr_info() should be sufficient IMO.

> As CONFIG_X86_INTEL_PSTATE is set to Y by default, I wasn't enable to
> reload it in any way.
>
> By reading the code, most of the code path and return options doesn't
> have a single pr_<something> call to explain why.
>
> So I had to rebuild the kernel + my patch to understand which path was
> taken and then find the root cause of why the pstate behavior changed.
>
> I wanted to contribute back my experience here by providing messages to
> ease the understanding and potentially debugging of the driver without
> recompiling it.
>
>
> So the root of this patch is being able to report the main reasons of
> why the driver didn't engaged itself with a pr_warn (could be also a
> pr_info).
>
> All the major and probable "return -ENODEV" calls before pr_info("Intel
> P-state driver initializing\n") deserves to be explicit and reachable on
> dmesg for the operators.
>
> I'm operating 30K+ servers and having this kind direct information would
> save serious time when debugging this situations.
>
> If my experience in that area could help other users, I'd be happy.
>
> I'm positing a v5 with all those changes.

Many thanks for your contribution!
