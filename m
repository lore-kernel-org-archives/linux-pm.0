From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] Do not modify MSR_IA32_ENERGY_PERF_BIAS in kernel
Date: Fri, 4 Mar 2016 13:56:10 +0100
Message-ID: <CAJZ5v0ie-itnxERzA3nhd0VnQUo07MsoyS3+WL+3sm5V+sMTJg@mail.gmail.com>
References: <4687430.mfM0GbdeDL@skinner>
	<16028318.H9OZ9hFYY1@skinner>
	<11753995.6ynq8tUiQx@vostro.rjw.lan>
	<1770444.1VxdmEr8lv@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1770444.1VxdmEr8lv@skinner>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Fri, Mar 4, 2016 at 9:37 AM, Thomas Renninger <trenn@suse.de> wrote:
> On Wednesday, March 02, 2016 01:26:18 AM Rafael J. Wysocki wrote:
>> On Tuesday, March 01, 2016 01:17:37 PM Thomas Renninger wrote:
>> > > >         if (!cpu_has(c, X86_FEATURE_EPB))z
>> > > >
>> > > >                 return;
>> > > >
>> > > > @@ -387,10 +391,8 @@ static void init_intel_energy_perf(struc
>> > > >
>> > > >         if ((epb & 0xF) != ENERGY_PERF_BIAS_PERFORMANCE)
>> > > >
>> > > >                 return;
>> > > >
>> > > > -       pr_warn_once("ENERGY_PERF_BIAS: Set to 'normal', was
>> >
>> > 'performance'\n");
>> >
>> > > > -       pr_warn_once("ENERGY_PERF_BIAS: View and update with
>> > > > x86_energy_perf_policy(8)\n"); -        epb = (epb & ~0xF) |
>> > > > ENERGY_PERF_BIAS_NORMAL;
>> > > > -       wrmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
>> > > > +       pr_info_once("ENERGY_PERF_BIAS is set to 'performance'\n");
>> > > > +       pr_info_once("ENERGY_PERF_BIAS: Update with cpupower-
> set(8)\n");
>> > >
>> > > This doesn't need to be cpupower-set IMO.
>> >
>> > You mean why switch the message from:
>> > x86_energy_perf_policy to cpupower-set
>> > ?
>> >
>> > IMO x86_energy_perf_policy should not exist. It has been introduce before
>> > cpupower set -b.
>> > Having an extra tool/binary for this functionality is an unneeded
>> > packaging
>> > overhead for distros.
>> > Also having more and more of such CPU specific tools is not userfriendly.
>> > cpupower supports all power relevant features of your CPU and on all
>> > architectures (or at least it should). People should know this one better
>> > than "x86_energy_perf_policy" and theoretically intuitively find it, even
>> > without a message.
>> >
>> > So it would be nice to get the message fixed as well.
>>
>> My point is that since "cpupower set -b" is not the only way to set this,
>> it doesn't seem appropriate to refer to it explicitly from a kernel message.
>>
>> I actually don't think the second message is necessary at all.
>
> Hmm, thinking a bit more about this, I think the whole
> init_intel_energy_perf() function check should vanish.
>
> The check should get moved into the powertop userspace tool.
> This one is used to optimize platform for power saving features.
>
> This would also keep the kernel core code clean...
>
> If you agree I will send the patch.

I need to talk to Len about that, but why don't you send it anyway?

If we are not going to update the knob, I'm not seeing much value in
checking it from the kernel.  A few people read boot logs if their
systems work as expected, so the value of the message alone is quite
limited IMO.

Thanks,
Rafael
