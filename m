From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] [RESEND] Do not modify perf bias performance setting by
 default at boot
Date: Mon, 18 Mar 2019 12:40:46 +0100
Message-ID: <CAJZ5v0jAY8OcTMKu4fn7NKVn0E+MqnWSUbSBLUjg0+2adnJ+7Q@mail.gmail.com>
References: <6369897.qxlu8PgE1t@house> <2947538.dvgdW3vLlg@house>
 <CAJZ5v0jS=9+O1J9w=a1K4U5UbXPKegVM-xKKwZN9XY4ObkQJkQ@mail.gmail.com> <2616815.TtRSCVe66q@house>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2616815.TtRSCVe66q@house>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Hannes Reinecke <hare@suse.de>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@suse.de>, Simon Schricker <sschricker@suse.de>, Srinivas Pandruvada <srinivas.pandruvada@intel.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 18, 2019 at 12:15 PM Thomas Renninger <trenn@suse.de> wrote:
>
> On Monday, March 18, 2019 11:26:10 AM CET Rafael J. Wysocki wrote:
> > On Fri, Mar 15, 2019 at 4:36 PM Thomas Renninger <trenn@suse.de> wrote:
> > > Hi Rafael,
> > >
>
> ...
>
> > > On my workstation the BIOS initializes perf bias to:
> > > cpupower info
> > > analyzing CPU 0:
> > > perf-bias: 7
> > >
> > > I could grep through quite some dozens of machines..., but these are
> > > mostly
> > > servers and probably show either "zero"/"performance" or "6"/"normal"
> > > because the Linux kernel overrides the INTENDED performance perf bias
> > > value to 6.
> > The perf bias Intended by whom?
>
> The instance who should be in charge to set/init such a value:
> BIOS?

And who's BIOS, really?  I guess you mean the OEM?  Note, however,
that the user and the OEM may not agree on that, but whatever.

> > Yes, the kernel replaces whatever the original BIOS setting is with
> > its own one.
>
> No, it only replaces the "performance" (0) value with "normal" (6).
> This does not makes sense and is broken.

OK, fair enough.

I guess it would have been better to set it to 6 unconditionally.

What about the systems that will misbehave when it is left at 0?

> > It may not match every setup perfectly, but at least it
> > is consistent.  Why exactly is it worse than whatever the BIOS has
> > set?
>
> Because there may be BIOS settings for the CPU which justify initialization
> of the Perf BIAS value by BIOS.

Well, the EPB is there for users to set it via the OS.  The BIOS
setting is not guaranteed to work for all users anyway.

> What sense does it make to unconditionally set perf BIAS value from
> performance to balanced?
> Why is this done?

Basically, for HW health reasons AFAICS.

Apparently, on some systems EPB=0 is (was?) special and means (meant?)
very aggressive use of turbo etc. which is not healthy in general.

> > > So we (SUSE) are going with this patch forever.
> > >
> > > Otherwise we would run into a similar support nightmare we ran into, when
> > > Intel decided to ignore CPU idle states as exported by BIOS through ACPI.
> > > BIOS documentation of all big server vendors mentioned "performance"
> > > settings. With a kernel update these BIOS C states settings have been
> > > ignored (some long latency once were not exported on purpose).
> > >
> > > The list of breaking conventions and specifications is long...
> > > People mostly blame the "bad BIOS developer". In this case things have
> > > been
> > > broke by the kernel.
> >
> > I agree that the kernel should not modify the EPB on system-wide
> > resume and on CPU online, but I don't see why changing the BIOS
> > setting at init time is a problem really.
>
> I would agree if we differ a tablet/laptop system and set the performance
> value to normal/powersave.
> And on a server we set it from normal/powersave to performance.
>
> But we should not touch this value anyway.
> Again: Why should the kernel touch it?
>
> There may be BIOSes initialzing it via BIOS options. And this is a very valid
> thing to do.

Yes, and there may be BIOSes leaving it at 0 with the assumption that
the OS will adjust it.  The kernel cannot know which is the case.

> > > It's now (with the resume patch) broken in way, that "performance" setting
> >
> > So the point seems to be that the BIOS setting should be preserved or
> > people are not able to configure the systems for performance through
> > setting things in the BIOS.
> > However, that only means that setting
> > things in the BIOS is not sufficient to configure a system for
> > performance and that has always been the case AFAICS, with or without
> > the EPB.
>
> ?!?
> If the kernel unconditionally, without documentation overrides such values...
> (and in this case only because of a workaround of some buggy BIOSes not
> initialzing this value)...

I acknowledge that the lack of documentation is a problem.

> > If you want to configure a system for performance, you need to do that
> > not just in the BIOS, but also in the OS (and, quite arguably, I would
> > expect the latter to be sufficient).
>
> No. You must not ignore BIOS settings. Even worse, you must not override
> these without any sane reason.

While there are BIOS settings that better should not be overridden,
the EPB is not one of them.

> Your assumption above might be right. But we want to do it better, right?
>
> ...
>
> > The system-wide resume part will still not be working properly after
> > the reverts.
>
> But it must never blindly (unconditionally) be set to specific value.
> Correct?

Yes.  I've already said that.

> You mean the kernel should store the pre-hibernation perf BIAS value
> in NVRAM and write it back when waking up again?

Or in the image and yes, it should write it back.

> This would make sense.
>
> It would also mean perf BIAS never really worked, at least did not survive
> suspend.

Right.

> On servers (no hibernation) it would works but is overridden
> to a value you typically do not want to have on a server...
> So the current situation is rather broken in the kernel.

Well, you can say so, but fixing it really means something more than
reverting the commits that your patch is reverting and *that* is my
point.

Yes, I think that this needs to be fixed.

No, I don't think that the reverts you are proposing are the way to go here.

Thanks,
Rafael
