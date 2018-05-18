From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC/RFT] [PATCH 02/10] cpufreq: intel_pstate: Conditional
 frequency invariant accounting
Date: Fri, 18 May 2018 09:36:40 +0200
Message-ID: <CAJZ5v0iBUuYr7xBYoH=vmevXVDvsdDtMLg_BVo9uKASVqOONZw@mail.gmail.com>
References: <20180516044911.28797-3-srinivas.pandruvada@linux.intel.com>
 <20180516151925.GO28366@localhost.localdomain> <20180516154733.GF12198@hirez.programming.kicks-ass.net>
 <20180516163105.GP28366@localhost.localdomain> <20180517105907.GC22493@localhost.localdomain>
 <20180517150418.GF22493@localhost.localdomain> <1526571692.11765.10.camel@linux.intel.com>
 <20180517161649.GX12217@hirez.programming.kicks-ass.net> <1526575358.11765.14.camel@linux.intel.com>
 <CAJZ5v0j82sm94iCpLOVMBwoSksKx1Y49RfJv=nhhJiKhenZykg@mail.gmail.com> <20180517182803.GY12217@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180517182803.GY12217@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mel Gorman <mgorman@techsingularity.net>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, May 17, 2018 at 8:28 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, May 17, 2018 at 06:56:37PM +0200, Rafael J. Wysocki wrote:
>> On Thu, May 17, 2018 at 6:42 PM, Srinivas Pandruvada
>
>> > What will happen if we look at all core turbo as max and cap any
>> > utilization above this to 1024?
>>
>> I was going to suggest that.
>
> To the basic premise behind all our frequency scaling is that there's a
> linear relation between utilization and frequency, where u=1 gets us the
> fastest.
>
> Now, we all know this is fairly crude, but it is what we work with.
>
> OTOH, the whole premise of turbo is that you don't in fact know what the
> fastest is, and in that respect setting u=1 at the guaranteed or
> sustainable frequency makes sense.
>
> The direct concequence of allowing clipping is that u=1 doesn't select
> the highest frequency, but since we don't select anything anyway
> (p-code does that for us) all we really need is to have u=1 above that
> turbo activation point you mentioned.
>
> For parts where we have to directly select frequency this obviously
> comes apart.
>
> However; what happens when the sustainable freq drops below our initial
> 'max'? Imagine us dropping below the all-core-turbo because of AVX. Then
> we're back to running at u<1 at full tilt.
>
> Or for mobile parts, the sustainable frequency could drop because of
> severe thermal limits. Now I _think_ we have the possibility for getting
> interrupts and reading the new guaranteed frequency, so we could
> re-guage.
>
> So in theory I think it works, in practise we need to always be able to
> find the actual max -- be it all-core turbo, AVX or thermal constrained
> frequency. Can we do that in all cases?

We should be, but unfortunately that's a dynamic thing.

For example, the AVX limit only kicks in when AVX instructions are executed.

> I need to go back to see what the complains against Vincent's proposal
> were, because I really liked the fact that it did away with all this.

That would be the best way to deal with this mess, I agree.
