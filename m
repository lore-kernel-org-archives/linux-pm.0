From: "Srivatsa S. Bhat" <srivatsa@MIT.EDU>
Subject: Re: [PATCH v2] cpufreq: Don't destroy/realloc policy/sysfs on
 hotplug/suspend
Date: Tue, 15 Jul 2014 12:28:54 +0530
Message-ID: <53C4D12E.3040807@mit.edu>
References: <1404959850-11617-1-git-send-email-skannan@codeaurora.org>
 <1405052287-4744-1-git-send-email-skannan@codeaurora.org>
 <CAKohponB9feyh50p+dL5hyU1ffHAzHU59G-sYCrCm1AbHQe9hw@mail.gmail.com>
 <2f549e6e4871ccf2a94dd4c8872c7a0b.squirrel@www.codeaurora.org>
 <CAKohpokhmj1OkCRj=X+Q7eYiun8fsqD2dpEt66VKYnqo3dENVA@mail.gmail.com>
 <53C0A12A.2060204@codeaurora.org>
 <CAKohpon9en_VnSx+CVydPsWBHtArvmazn0hrodrRJt9jgOa0-g@mail.gmail.com>
 <53C42AA8.8010107@codeaurora.org>
 <CAKohpomkqbHZo9KrJMSwsEKGt6+Ac2Fg2X0+S7ZAo=OzhAc45g@mail.gmail.com>
 <53C4BDFB.70707@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <53C4BDFB.70707@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Saravana Kannan <skannan@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Todd Poynor <toddpoynor@google.com>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 07/15/2014 11:06 AM, Saravana Kannan wrote:
> On 07/14/2014 09:35 PM, Viresh Kumar wrote:
>> On 15 July 2014 00:38, Saravana Kannan <skannan@codeaurora.org> wrote:
>>> Yeah, it definitely crashes if policy->cpu if an offline cpu. Because
>>> the
>>> mutex would be uninitialized if it's stopped after boot or it would
>>> never
>>> have been initialized (depending on how you fix policy->cpu at boot).
>>>
>>> Look at this snippet on the actual tree and it should be pretty evident.
>>
>> Yeah, I missed it. So the problem is we initialize timer_mutex's for
>> policy->cpus. So we need to do that just for policy->cpu and also we
>> don't
>> need a per-cpu timer_mutex anymore.
>>
> 
> Btw, I tried to take a stab at removing any assumption in cpufreq code
> about policy->cpu being ONLINE.

Wait, allowing an offline CPU to be the policy->cpu (i.e., the CPU which is
considered as the master of the policy/group) is just absurd. If there is
no leader, there is no army. We should NOT sacrifice sane semantics for the
sake of simplifying the code.

> There are 160 instances of those of with
> 23 are in cpufreq.c
>

And that explains why. It is just *natural* to assume that the CPUs governed
by a policy are online. Especially so for the CPU which is supposed to be
the policy leader. Let us please not change that - it will become
counter-intuitive if we do so. [ The other reason is that physical hotplug
is also possible on some systems... in that case your code might make a CPU
which is not even present (but possible) as the policy->cpu.. and great 'fun'
will ensue after that ;-( ]

The goal of this patchset should be to just de-couple the sysfs files/ownership
from the policy->cpu to an extent where it doesn't matter who owns those
files, and probably make it easier to do CPU hotplug without having to
destroy and recreate the files on every hotplug operation.

This is exactly why the _implementation_ matters in this particular case -
if we can't achieve the simplification by keeping sane semantics, then we
shouldn't do the simplification!

That said, I think we should keep trying - we haven't exhausted all ideas
yet :-)

Regards,
Srivatsa S. Bhat

> So, even if we are sure cpufreq.c is fine, it's 137 other uses spread
> across all the other files. I definitely don't want to try and fix those
> as part of this patch. Way too risky and hard to get the test coverage
> it would need. Even some of the acpi cpufreq drivers seem to be making
> this assumption.
> 
> Btw, I think v3 is done. I did some testing and it was fine. But made
> some minor changes. Will test tomorrow to make sure I didn't break
> anything with the minor changes and then send them out.
> 
