From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH] cpufreq: exynos: Broadcast frequency change notifications
 for all cores
Date: Thu, 31 Jan 2013 16:04:13 +0100
Message-ID: <1520678.Zm627xxIN3@amdc1227>
References: <1887364.fvxYYNb7Mm@amdc1227> <1520677.WES295RohH@amdc1227>
 <CAKohpombSKY-HMXovBAyZd5Ce8ZAEo2+yiwYL1G4=OEUJM1u5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAKohpombSKY-HMXovBAyZd5Ce8ZAEo2+yiwYL1G4=OEUJM1u5g@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On Thursday 31 of January 2013 20:22:50 Viresh Kumar wrote:
> On 31 January 2013 20:15, Tomasz Figa <t.figa@samsung.com> wrote:
> > On Thursday 31 of January 2013 09:50:37 Viresh Kumar wrote:
> >> > +               policy->shared_type = CPUFREQ_SHARED_TYPE_ANY;
> >> 
> >> I couldn't understand the use of this change. Can you please explain
> >> ?
> > 
> > All cores on Exynos SoCs share the same clock source, which means that
> > they all always run at the same frequency. So setting frequency on one
> > core sets the frequency on all cores and so it doesn't matter on which
> > core the frequency setting operation is done.
> 
> Great, that's like most other platforms and for this you just need to
> set mask of all the possible cpus (online or offline) into policy->cpus
> > As you can see in include/linux/cpufreq.h:
> > 
> > #define CPUFREQ_SHARED_TYPE_ANY  (3) /* Freq can be set from any
> > dependent CPU*/
> > 
> > which basically tells (together with rest of the patch) the cpufreq
> > subsystem about what I wrote earlier.
> 
> I don't think so. Because i wasn't using it on my system and it was
> working well.
> Then i grepped it in kernel source
> 
> viresh@blr-linut-001:$ git grep shared_type drivers/cpufreq/
> drivers/cpufreq/acpi-cpufreq.c: if (policy->shared_type !=
> CPUFREQ_SHARED_TYPE_ANY)
> drivers/cpufreq/acpi-cpufreq.c: policy->shared_type = perf->shared_type;
> drivers/cpufreq/acpi-cpufreq.c: if (policy->shared_type ==
> CPUFREQ_SHARED_TYPE_ALL ||
> drivers/cpufreq/acpi-cpufreq.c:     policy->shared_type ==
> CPUFREQ_SHARED_TYPE_ANY) {
> drivers/cpufreq/acpi-cpufreq.c:         policy->shared_type =
> CPUFREQ_SHARED_TYPE_ALL;
> drivers/cpufreq/acpi-cpufreq.c:         policy->shared_type =
> CPUFREQ_SHARED_TYPE_HW;
> drivers/cpufreq/cpufreq-cpu0.c: policy->shared_type =
> CPUFREQ_SHARED_TYPE_ANY; drivers/cpufreq/db8500-cpufreq.c:      
> policy->shared_type =
> CPUFREQ_SHARED_TYPE_ALL;
> drivers/cpufreq/omap-cpufreq.c:         policy->shared_type =
> CPUFREQ_SHARED_TYPE_ANY;
> drivers/cpufreq/speedstep-centrino.c:           if
> (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
> drivers/cpufreq/speedstep-centrino.c:           if
> (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
> 
> I couldn't see any core file using this stuff other than acpi-cpufreq.c,
> which is for x86 only systems if i am not wrong.
> 
> @Rafael: You view on this.. ? Actually i believe it was just used by
> many ARM drivers without knowing the real use of it and new drivers
> have just followed it.
> 
> I can get a patch to fix it at all places if you agree.
> 
> BTW, grep in full kernel source gave, which is again acpi only:
> 
> viresh@blr-linut-001:$ git grep shared_type
> 
> arch/arm/mach-tegra/cpu-tegra.c:        policy->shared_type =
> CPUFREQ_SHARED_TYPE_ALL;
> drivers/acpi/processor_perflib.c:
> pr->performance->shared_type = CPUFREQ_SHARED_TYPE_ALL;
> drivers/acpi/processor_perflib.c:
> pr->performance->shared_type = CPUFREQ_SHARED_TYPE_HW;
> drivers/acpi/processor_perflib.c:
> pr->performance->shared_type = CPUFREQ_SHARED_TYPE_ANY;
> drivers/acpi/processor_perflib.c:
> match_pr->performance->shared_type =
> drivers/acpi/processor_perflib.c:
>  pr->performance->shared_type;
> drivers/acpi/processor_perflib.c:
> pr->performance->shared_type = CPUFREQ_SHARED_TYPE_ALL;
> drivers/acpi/processor_throttling.c:
> pthrottling->shared_type = DOMAIN_COORD_TYPE_SW_ALL;
> drivers/acpi/processor_throttling.c:    pthrottling->shared_type =
> pdomain->coord_type;
> drivers/acpi/processor_throttling.c:
> pthrottling->shared_type = DOMAIN_COORD_TYPE_SW_ALL;
> drivers/acpi/processor_throttling.c:    if (p_throttling->shared_type
> == DOMAIN_COORD_TYPE_SW_ANY) {
> drivers/acpi/processor_throttling.c:
> pthrottling->shared_type = DOMAIN_COORD_TYPE_SW_ALL;
> drivers/cpufreq/acpi-cpufreq.c: if (policy->shared_type !=
> CPUFREQ_SHARED_TYPE_ANY)
> drivers/cpufreq/acpi-cpufreq.c: policy->shared_type = perf->shared_type;
> drivers/cpufreq/acpi-cpufreq.c: if (policy->shared_type ==
> CPUFREQ_SHARED_TYPE_ALL ||
> drivers/cpufreq/acpi-cpufreq.c:     policy->shared_type ==
> CPUFREQ_SHARED_TYPE_ANY) {
> drivers/cpufreq/acpi-cpufreq.c:         policy->shared_type =
> CPUFREQ_SHARED_TYPE_ALL;
> drivers/cpufreq/acpi-cpufreq.c:         policy->shared_type =
> CPUFREQ_SHARED_TYPE_HW;
> drivers/cpufreq/cpufreq-cpu0.c: policy->shared_type =
> CPUFREQ_SHARED_TYPE_ANY; drivers/cpufreq/db8500-cpufreq.c:      
> policy->shared_type =
> CPUFREQ_SHARED_TYPE_ALL;
> drivers/cpufreq/omap-cpufreq.c:         policy->shared_type =
> CPUFREQ_SHARED_TYPE_ANY;
> drivers/cpufreq/speedstep-centrino.c:           if
> (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
> drivers/cpufreq/speedstep-centrino.c:           if
> (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
> drivers/net/wireless/rtlwifi/rtl8192ce/hw.c:
> rtlpcipriv->bt_coexist.bt_radio_shared_type =
> drivers/net/wireless/rtlwifi/rtl8723ae/hw.c:
> pcipriv->bt_coexist.bt_radio_shared_type =
> drivers/net/wireless/rtlwifi/rtl8723ae/hw.c:
> pcipriv->bt_coexist.bt_radio_shared_type);
> drivers/net/wireless/rtlwifi/wifi.h:    u8 bt_radio_shared_type;
> drivers/xen/xen-acpi-processor.c:       dst->shared_type =
> _pr->performance->shared_type;
> drivers/xen/xen-acpi-processor.c:
> dst->shared_type = CPUFREQ_SHARED_TYPE_ALL;
> drivers/xen/xen-acpi-processor.c:
> dst->shared_type = CPUFREQ_SHARED_TYPE_HW;
> drivers/xen/xen-acpi-processor.c:
> dst->shared_type = CPUFREQ_SHARED_TYPE_ANY;
> include/acpi/processor.h:       unsigned int shared_type;
> include/acpi/processor.h:       unsigned int shared_type;
> include/linux/cpufreq.h:        unsigned int            shared_type;
> /* ANY or ALL affected CPUs
> include/xen/interface/platform.h:       uint32_t shared_type;     /*
> coordination type of this processor */
> tools/perf/util/dwarf-aux.c:             tag == DW_TAG_shared_type);

Well, the fact that it isn't used at the moment doesn't mean that it 
shouldn't be set correctly. The field is present in the structure and has 
a set of defined values - one of which should be selected. For example,
I can imagine some governor taking this information into account.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Linux Platform
