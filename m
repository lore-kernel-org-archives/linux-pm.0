From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Commit 554c8aa8ecad causing severe performance degression with pcc-cpufreq
Date: Tue, 17 Jul 2018 12:23:51 +0200
Message-ID: <CAJZ5v0gdbopHE5Kbhw3h7Hj7bqmDKeoReNoRXJ2gYxQROQQ6iw@mail.gmail.com>
References: <20180717065048.74mmgk4t5utjaa6a@suselix> <20180717092721.onkaf3qsu7te6syi@suselix>
 <20180717093620.ym6phfmr3rfvsxyo@suselix> <3724084.DyflrVPzDS@aspire.rjw.lan> <20180717102136.snayvzmv2h3dcwiq@suselix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717102136.snayvzmv2h3dcwiq@suselix>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Herrmann <aherrmann@suse.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 17, 2018 at 12:21 PM, Andreas Herrmann <aherrmann@suse.com> wrote:
> On Tue, Jul 17, 2018 at 12:09:21PM +0200, Rafael J. Wysocki wrote:
>> On Tuesday, July 17, 2018 11:36:20 AM CEST Andreas Herrmann wrote:
>> > On Tue, Jul 17, 2018 at 11:27:21AM +0200, Andreas Herrmann wrote:
>> > > On Tue, Jul 17, 2018 at 11:23:25AM +0200, Rafael J. Wysocki wrote:
>> > > > On Tue, Jul 17, 2018 at 11:11 AM, Andreas Herrmann <aherrmann@suse.com> wrote:
>> > > > > On Tue, Jul 17, 2018 at 11:06:29AM +0200, Rafael J. Wysocki wrote:
>> > > > >> On Tue, Jul 17, 2018 at 10:50 AM, Andreas Herrmann <aherrmann@suse.com> wrote:
>> > > > >>
>> > > > >> [cut]
>> > > > >>
>> > > > >> >
>> > > > >> > On balance before this commit users could use pcc-cpufreq but had
>> > > > >> > already suboptimal performance (compared to say intel_pstate driver
>> > > > >> > which can be used changing BIOS options).
>> > > > >>
>> > > > >> BTW, I wonder why you need to change the BIOS options for intel_pstate to load.
>> > > > >
>> > > > > I think this is because of (in intel_pstate_init()):
>> > > > >
>> > > > >         /*
>> > > > >          * The Intel pstate driver will be ignored if the platform
>> > > > >          * firmware has its own power management modes.
>> > > > >          */
>> > > > >         if (intel_pstate_platform_pwr_mgmt_exists())
>> > > > >                 return -ENODEV;
>> > > > >
>> > > >
>> > > > OK, because of the "Proliant" entry, right?
>> > > >
>> > > > So it looks like we have an issue there.  We find the entry and we
>> > > > look for _PSS.  It is not there, so we assume that the firmware is
>> > > > expected to control performance, which is not the case.
>> >
>> > FYI, there is another BIOS setting on those systems. It's called
>> > "Collaborative Power Control" (AFAIK enabled by default).
>> >
>> > Only if this is disabled, firmware is (alone) in control of
>> > performance. (And of course in this case neither pcc-cpufreq nor
>> > intel_pstate will be loaded).
>>
>> OK, the patch is below.
>>
>> First, I hope that if "Collaborative Power Control" is disabled, it will
>> simply hide the PCCH object and so intel_pstate will still not load then.
>
> PCCH is hidden in that case.

OK

>> The main question basically is what the OS is expected to do if
>> "Dynamic Power Savings Mode" is set.  If we are *expected* to use
>> the PCC interface then, intel_pstate may not work in that case, but
>> I suspect that the PCC interface allows extra energy to be saved
>> over what is possible without it.
>
> I'll test it and see what happens.

Thanks!
