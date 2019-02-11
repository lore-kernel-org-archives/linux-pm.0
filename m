From: Erwan Velu <erwanaliasr1@gmail.com>
Subject: Re: [PATCH v3] cpufreq: intel_pstate: Reporting reasons why driver
 prematurely exit
Date: Mon, 11 Feb 2019 22:34:30 +0100
Message-ID: <CAL2Jzuwz3gYmYwiP-6mRN5HS65oXMKR1V7997d92K_n+fJt7QQ@mail.gmail.com>
References: <20190211093140.23608-1-e.velu@criteo.com> <eaf4286b0836444e00ec2e92178b5f31957c9a7a.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <eaf4286b0836444e00ec2e92178b5f31957c9a7a.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: e.velu@criteo.com, Liam.Howlett@oracle.com, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "open list:INTEL PSTATE DRIVER" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

I understand your concern but I'd like to defend my use case ;)

I was in a case where I didn't noticed that intel_pstate did engaged
after a kernel upgrade while it didn't before.
But there strictly no information message why the driver took the
decision not to load (aka considering there is already a power
management system engaged).

That had a major impact on the system performance without _any_ notice.

So I would have found helpful to have informative message about the
reason why it didn't loaded.
A intel_pstate is usually set (and by default) to Y, which prevent
debugging this live and enforce a kernel reboot which was an issue in
my production case.
So I would agree to put some details in pr_debug() but keep the
important return path being explicit to help user understanding
(withtout triggering the debug) why it did behave like that giving
serious hints (kernel, bios, fw update).

Would you agree if I update the patch this way ?
Thx !
Erwan,

Le lun. 11 f=C3=A9vr. 2019 =C3=A0 22:25, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> a =C3=A9crit :
>
> On Mon, 2019-02-11 at 10:31 +0100, Erwan Velu wrote:
> > The init code path have several execeptions where the module can
> > decide not to load.
> > As CONFIG_X86_INTEL_PSTATE is generally set to Y, the return code is
> > not reachable.
> > The initialisation code is neither verbose of the reason why it did
> > choose to prematurely exit.
> >
> > This situation leads to situation where its difficult for a user to
> > determine,
> > on a given platform, why the driver didn't loaded properly.
> >
> > This patch is about reporting to the user the reason/context why the
> > driver failed to load.
> > That is a precious hint when debugging a platform.
> pr_info and pr_warn are too strong for this debug use case. Anytime
> someone see some error in dmesg, we have an additional work to explain
> that that is not a problem to an average user. So this is an
> maintenance overhead for the purpose of debugging. Only few users who
> are really trying to debug, will care for these errors. For them
> pr_debug will be enough, we have other pr_debugs which will be helpful
> to root cause the issue, even if driver loads.
>
> Also when some user disabled intel_pstate via kernel command line,
> additional debug message is not useful.
>
> Thanks,
> Srinivas
>
> >
> > Signed-off-by: Erwan Velu <e.velu@criteo.com>
> > ---
> >  drivers/cpufreq/intel_pstate.c | 36 ++++++++++++++++++++++++++----
> > ----
> >  1 file changed, 28 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index dd66decf2087..ba2e2aee6c20 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -2475,6 +2475,7 @@ static bool __init
> > intel_pstate_no_acpi_pss(void)
> >               kfree(pss);
> >       }
> >
> > +     pr_info("Cannot detect ACPI PSS");
> >       return true;
> >  }
> >
> > @@ -2484,10 +2485,16 @@ static bool __init
> > intel_pstate_no_acpi_pcch(void)
> >       acpi_handle handle;
> >
> >       status =3D acpi_get_handle(NULL, "\\_SB", &handle);
> > -     if (ACPI_FAILURE(status))
> > +     if (ACPI_FAILURE(status)) {
> > +             pr_info("Cannot detect ACPI SB");
> >               return true;
> > +     }
> >
> > -     return !acpi_has_method(handle, "PCCH");
> > +     status =3D acpi_has_method(handle, "PCCH");
> > +     if (!status) {
> > +             pr_info("Cannot detect ACPI PCCH");
> > +     }
> > +     return !status;
> >  }
> >
> >  static bool __init intel_pstate_has_acpi_ppc(void)
> > @@ -2502,6 +2509,7 @@ static bool __init
> > intel_pstate_has_acpi_ppc(void)
> >               if (acpi_has_method(pr->handle, "_PPC"))
> >                       return true;
> >       }
> > +     pr_info("Cannot detect ACPI PPC");
> >       return false;
> >  }
> >
> > @@ -2592,8 +2600,10 @@ static int __init intel_pstate_init(void)
> >       const struct x86_cpu_id *id;
> >       int rc;
> >
> > -     if (no_load)
> > +     if (no_load) {
> > +             pr_info("disabling as per user-request\n");
> >               return -ENODEV;
> > +     }
> >
> >       id =3D x86_match_cpu(hwp_support_ids);
> >       if (id) {
> > @@ -2606,31 +2616,41 @@ static int __init intel_pstate_init(void)
> >               }
> >       } else {
> >               id =3D x86_match_cpu(intel_pstate_cpu_ids);
> > -             if (!id)
> > +             if (!id) {
> > +                     pr_warn("CPU ID is not in the list of supported
> > devices\n");
> >                       return -ENODEV;
> > +             }
> >
> >               copy_cpu_funcs((struct pstate_funcs *)id->driver_data);
> >       }
> >
> > -     if (intel_pstate_msrs_not_valid())
> > +     if (intel_pstate_msrs_not_valid()) {
> > +             pr_warn("Cannot enable driver as per invalid MSRs\n");
> >               return -ENODEV;
> > +     }
> >
> >  hwp_cpu_matched:
> >       /*
> >        * The Intel pstate driver will be ignored if the platform
> >        * firmware has its own power management modes.
> >        */
> > -     if (intel_pstate_platform_pwr_mgmt_exists())
> > +     if (intel_pstate_platform_pwr_mgmt_exists()) {
> > +             pr_warn("Platform already taking care of power
> > management\n");
> >               return -ENODEV;
> > +     }
> >
> > -     if (!hwp_active && hwp_only)
> > +     if (!hwp_active && hwp_only) {
> > +             pr_warn("HWP not present\n");
> >               return -ENOTSUPP;
> > +     }
> >
> >       pr_info("Intel P-state driver initializing\n");
> >
> >       all_cpu_data =3D vzalloc(array_size(sizeof(void *),
> > num_possible_cpus()));
> > -     if (!all_cpu_data)
> > +     if (!all_cpu_data) {
> > +             pr_warn("Cannot allocate memory\n");
> >               return -ENOMEM;
> > +     }
> >
> >       intel_pstate_request_control_from_smm();
> >
>
