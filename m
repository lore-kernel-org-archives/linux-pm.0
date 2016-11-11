From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] tools/power turbostat: Disable HWP OOB status
Date: Fri, 11 Nov 2016 14:25:10 -0800
Message-ID: <1478903110.20074.5.camel@linux.intel.com>
References: <1478902499-21293-1-git-send-email-srinivas.pandruvada@linux.intel.com>
         <CAJZ5v0gmRucf71PmqF+J1vOoYW_dBgs6t+40SNZhB6JxUF-n6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:27269 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964930AbcKKWZL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Nov 2016 17:25:11 -0500
In-Reply-To: <CAJZ5v0gmRucf71PmqF+J1vOoYW_dBgs6t+40SNZhB6JxUF-n6Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>

On Fri, 2016-11-11 at 23:18 +0100, Rafael J. Wysocki wrote:
> On Fri, Nov 11, 2016 at 11:14 PM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > Display if the HWP is enabled in OOB (Out of band) mode.
> 
> Hmm.  Should the subject be "tools/power turbostat: Display HWP OOB
> status"?
yikes. I don't know how I wrote this. This should be "Display" instead
of "Disable"

Thanks,
Srinivas

> 
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel
> > .com>
> > ---
> >  tools/power/x86/turbostat/turbostat.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/power/x86/turbostat/turbostat.c
> > b/tools/power/x86/turbostat/turbostat.c
> > index 3e199b5..27fb0f0 100644
> > --- a/tools/power/x86/turbostat/turbostat.c
> > +++ b/tools/power/x86/turbostat/turbostat.c
> > @@ -3174,10 +3174,11 @@ void decode_misc_pwr_mgmt_msr(void)
> >                 return;
> > 
> >         if (!get_msr(base_cpu, MSR_MISC_PWR_MGMT, &msr))
> > -               fprintf(outf, "cpu%d: MSR_MISC_PWR_MGMT: 0x%08llx
> > (%sable-EIST_Coordination %sable-EPB)\n",
> > +               fprintf(outf, "cpu%d: MSR_MISC_PWR_MGMT: 0x%08llx
> > (%sable-EIST_Coordination %sable-EPB %sable-OOB)\n",
> >                         base_cpu, msr,
> >                         msr & (1 << 0) ? "DIS" : "EN",
> > -                       msr & (1 << 1) ? "EN" : "DIS");
> > +                       msr & (1 << 1) ? "EN" : "DIS",
> > +                       msr & (1 << 8) ? "EN" : "DIS");
> >  }
> > 
> >  void process_cpuid()
> > --
> 
> Thanks,
> Rafael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
