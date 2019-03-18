From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] [RESEND] Do not modify perf bias performance setting by
 default at boot
Date: Mon, 18 Mar 2019 11:26:10 +0100
Message-ID: <CAJZ5v0jS=9+O1J9w=a1K4U5UbXPKegVM-xKKwZN9XY4ObkQJkQ@mail.gmail.com>
References: <6369897.qxlu8PgE1t@house> <CAJZ5v0h3zLrqqMXzt_cqGV1rBR0muosZwy1Zu3fV9O1kqGc6gw@mail.gmail.com>
 <2947538.dvgdW3vLlg@house>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2947538.dvgdW3vLlg@house>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Hannes Reinecke <hare@suse.de>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@suse.de>, Simon Schricker <sschricker@suse.de>, Srinivas Pandruvada <srinivas.pandruvada@intel.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 15, 2019 at 4:36 PM Thomas Renninger <trenn@suse.de> wrote:
>
> Hi Rafael,
>
> On Thursday, March 14, 2019 11:08:03 PM CET Rafael J. Wysocki wrote:
> > On Thu, Mar 14, 2019 at 3:42 PM Thomas Renninger <trenn@suse.de> wrote:
> > > This is a revert of mainline git commits:
> > > commit b51ef52df71cb28e9d90cd1d48b79bf19f0bab06
> > > commit 17edf2d79f1ea6dfdb4c444801d928953b9f98d6
> > > commit abe48b108247e9b90b4c6739662a2e5c765ed114
> >
> > I'm not quite convinced that reverting these is the right thing to do here.
>
> Ok, I try harder.
>
> > > It is about this kernel message showing up on quite a lot servers:
> > > [    0.072652] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
> > > [    0.076003] ENERGY_PERF_BIAS: View and update with
> > > x86_energy_perf_policy(8)
> > What happens on boot is a matter of convention and the convention by
> > which the EPB is set to "neutral" at that point has been used for
> > quite a while.  Changing it now may confuse some users or even worse.
>
> SUSE has this patch included for quite a while (in all kind of
> SLE 12 SP flavors), possibly other distributions as well.
> Unfortunately the patch got removed recently, because my commit (this one)
> was ignored by Len a while ago.
>
> I also like to see more examples of BIOSes not initializing this value.
> This message is rare (so the setting back does not happen often, probably
> only wrongly with latest BIOSes overriding intended BIOS performance settings
> on servers).
>
> On my workstation the BIOS initializes perf bias to:
> cpupower info
> analyzing CPU 0:
> perf-bias: 7
>
> I could grep through quite some dozens of machines..., but these are mostly
> servers and probably show either "zero"/"performance" or "6"/"normal" because
> the Linux kernel overrides the INTENDED performance perf bias value to 6.

The perf bias Intended by whom?

Yes, the kernel replaces whatever the original BIOS setting is with
its own one.  It may not match every setup perfectly, but at least it
is consistent.  Why exactly is it worse than whatever the BIOS has
set?

> So we (SUSE) are going with this patch forever.
>
> Otherwise we would run into a similar support nightmare we ran into, when
> Intel decided to ignore CPU idle states as exported by BIOS through ACPI.
> BIOS documentation of all big server vendors mentioned "performance" settings.
> With a kernel update these BIOS C states settings have been ignored (some long
> latency once were not exported on purpose).
>
> The list of breaking conventions and specifications is long...
> People mostly blame the "bad BIOS developer". In this case things have been
> broke by the kernel.

I agree that the kernel should not modify the EPB on system-wide
resume and on CPU online, but I don't see why changing the BIOS
setting at init time is a problem really.

> It's now (with the resume patch) broken in way, that "performance" setting

So the point seems to be that the BIOS setting should be preserved or
people are not able to configure the systems for performance through
setting things in the BIOS.  However, that only means that setting
things in the BIOS is not sufficient to configure a system for
performance and that has always been the case AFAICS, with or without
the EPB.

If you want to configure a system for performance, you need to do that
not just in the BIOS, but also in the OS (and, quite arguably, I would
expect the latter to be sufficient).

> in the mainline kernel is unusable for years already.
>
> Can we please get this finally properly fixed!
>
> > That is a bug.  There is no reason to change the EPB on CPU
> > offline/online and I agree that this needs to be fixed.  The reverts
> > would make this problem go away, but that's not the only possible way
> > to fix it.
>
> It is the only proper way to fix this.

I beg to differ.

The system-wide resume part will still not be working properly after
the reverts.

> > Moreover, what is done during system-wide resume appears to be a bug
> > too.  Whatever EPB value is there during suspend should be saved and
> > it should be restored during resume. Reverting the commits above will
> > not fix that particular issue.
>
> Someone could have a look what happens on a recent system
> after suspend (with this patch on top).
> I do not have laptops to test suspend/resume with latest kernels.
> These broken patches have been added a bit too quickly.
>
> I doubt much BIOSes "forgot to initialize this value" and I have my doubts
> that resume let's the CPU fall back to "uninitialized" value.
> I more expect BIOS resets performance value after resume and the kernel is
> doing it all wrong.
> Hm, in fact this could be proofed by modifying perf bias value, do a suspend
> resume cyle. If the value is kept we should avoid another try of complicating
> things and simply reverting touching perf bias value altogether, correct?

No, AFAICS.

If the EPB value has been modified from user space after initializing
the system, that new value should be preserved across system-side
suspend/resume (and hibernation) and also (arguably) across CPU
online/offline.  Not the BIOS-set value, but the new one set by user
space.  The only way to guarantee the preservation of it across
suspend/resume is to save it at suspend time and restore it during
resume.  Relying on the BIOS to avoid touching it may be a bit overly
optimistic.

> BIOS probably does not store perf BIAS value and re-applies it after
> suspend resume. Some might re-set it to the intial value (performance...,
> D'oh).

Right.

Thanks,
Rafael
