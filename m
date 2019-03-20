From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] [RESEND] Do not modify perf bias performance setting by
 default at boot
Date: Wed, 20 Mar 2019 23:18:03 +0100
Message-ID: <CAJZ5v0h6tx_swhuQhZFsayszqtE2k3rO45VoDcrSieB6Z9NBgg@mail.gmail.com>
References: <6369897.qxlu8PgE1t@house> <3100343.nkNWlhakcz@house>
 <CAJZ5v0if=ypE-0j6baq4uTkDp5Ew_WO68oqL0dOi+tZhoP-4mQ@mail.gmail.com> <2885751.XIsKOnZRY2@house>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2885751.XIsKOnZRY2@house>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Hannes Reinecke <hare@suse.de>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@suse.de>, Simon Schricker <sschricker@suse.de>, Srinivas Pandruvada <srinivas.pandruvada@intel.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 20, 2019 at 3:17 PM Thomas Renninger <trenn@suse.de> wrote:
>
> Rafael,
>
> I top post the general things and answer in only a few sentences embedded in
> context below:
>
> I very much honour your work and your neutral opinions and reasoning and
> I always have.
>
> This patch is a resend and while I try to come up with alternative hacks,
> there still is no solution, not even a suggestion.

I have a patch to rework the EPB handling to avoid the offline/online
and suspend/resume issues which I'm going to post shortly.  It doesn't
change the current behavior on the first CPU bring-up, however, so
feel free to adjust it to your needs.

> I sent the patch 3 years ago:
> https://lkml.org/lkml/2016/2/26/675
> And I found this when doing performance analysis with Mel (Gorman).
>
> This time Hannes (Reinicke) stumbled over it, while he was working on
> performance tests on NVE over fabrics.
>
> We need this fixed and I am going to repush this into our kernel(s) now.

I'd recommend to wait for a while with that.

> On Monday, March 18, 2019 11:57:08 PM CET Rafael J. Wysocki wrote:
> > On Mon, Mar 18, 2019 at 2:22 PM Thomas Renninger <trenn@suse.de> wrote:
> > > On Monday, March 18, 2019 12:40:46 PM CET Rafael J. Wysocki wrote:
> > > > On Mon, Mar 18, 2019 at 12:15 PM Thomas Renninger <trenn@suse.de> wrote:
> > > ...
>
> ...
>
> > > > > > It may not match every setup perfectly, but at least it
> > > > > > is consistent.  Why exactly is it worse than whatever the BIOS has
> > > > > > set?
> > > > >
> > > > > Because there may be BIOS settings for the CPU which justify
> > > > > initialization
> > > > > of the Perf BIAS value by BIOS.
> > > >
> > > > Well, the EPB is there for users to set it via the OS.  The BIOS
> > > > setting is not guaranteed to work for all users anyway.
> > >
> > > Who says that?
> >
> > I do.
>
> And this is the reason you do not see much patches from myself anymore over
> the last years.
> It's certainly not your fault. I had quite some discussions with Len about
> specification and BIOS breakages.
>
> Especially in the CPU powersave area, idle states and cpufreq drivers, Intel
> was doing it differently all time long the last 5 years. Ignoring their own
> specifications, ignoring possible BIOS settings and changing kernel and
> userspace interfaces all the time.

It looks like you are generally frustrated and hopefully this isn't my fault.

I would like you to be more specific, though.

> And now I have the discussion again...

What discussion?

> While it is related to this patch, it gets off topic.
> I guess there should be a more general thread on lkml:
> "Do not change APIs every second day"
> Up to userspace, but also to BIOS.

I have no idea what you mean here, sorry.

> > And then we can get back to the initial setting discussion.
>
> Let's stick to this topic in this thread.
> There is no reason to not find a proper fix for this meanwhile.
>
> Overriding the BIOS setting should IMO only take place:
> - if lifetime of CPU could be affected as you mentioned. But in this case the
>   affected CPUs should be matched
> - if we expect that there are BIOSes which "want to set this value to 6,
>   but may have forgotten to do so", as mentioned in the original patch
>   from Len. BIOSes where this is the case should get a quirk to set it to 6.

On all of the laptops in my office where EPB is present the initial
value of it is 0 and I don't honestly think that this is really
intentional.  It looks to me like they don't initialize the EPB at
all, which unfortunately is hard to distinguish from an intentional
'performance' setting.

>
> Still, ideally the whole overriding and the message should vanish IMO.

We may consider doing that, but let's fix clear bugs first.

> Last time I sent this patch your answer was:
> "I need to talk to Len about that,"
> https://lkml.org/lkml/2016/3/4/371
>
> But as this is x86 kernel core code, I guess this should be discussed and
> pushed by the general x86 maintainers anyway. Sigh.
