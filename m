From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC/RFT][PATCH 0/1] cpufreq: New governor based on scheduler-provided utilization data
Date: Mon, 22 Feb 2016 00:16:11 +0100
Message-ID: <5059413.77KZsd2lep@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Everyone,

Usually, I don't send introductory messages for single patches, but this
one is an exception, because I didn't want to put all of my considerations
into the patch changelog.

So I have been told for a few times already that I should not introduce
interfaces passing arguments that aren't used in the current code and without
telling anyone what my plans for using those aguments in the future may be
(although IMO that would not be too hard to figure out), so here's an example.

Juri, that's not what you may have expected.  In fact, I didn't expect it to
look like this either when I started to think about it.  Initially, I was
considering to modify the existing governors to use the utilization data
somehow, but then I realized that it would make them behave differently and
that might confuse some.

So here it is: a new functional cpufreq governor.  It is very simple (arguably
on the verge of being overly simplistic), but it gets the job done.  I have only
tested it (very lightly) on a system with one CPU per cpufreq policy (so the
"shared" path in it is admittedly untested), but in that simple case the
frequency evidently follows the CPU utilization as expected.

The reason why I didn't post it earlier was because I needed to clean up the
existing governor code enough to be able to do anything new on top of it (you
might have noticed the cleanup work going during the last couple of weeks).

Now, there are a few observations to be made about it that may be interesting
to someone (they definitely are interesting to me).  Some of them are mentioned
in the patch changelog too.

First off, note how simple it is: 250 lines of code including struct definitions
and the boilerplate part (and the copyright notice and all).  It might be quite
difficult to invent something simpler and still doing significant work.

As is, it may not make the best scaling decisions (in particular, it will tend
to over-provision DL tasks), but at least it sould be very predictable.  I might
have added things like up_threshold and sampling_down_factor to it, but I decided
against doing that as it would muddy the waters a bit.  Also, when I had tested
it, it looked aggressive enough to me without those.

Second, note that the majority of work in it is done in the callbacks invoked
from scheduler code paths.  If cpufreq drivers are modified to provide a "fast
frequency update" method that will be practical to invoke from those paths, *all*
of the work in that governor may be done in there.  It's almost like the scheduler
telling the frequency scaling driver directly "this is your frequency, use it".

Next, it is hooked up to the existing cpufreq governor infrastructure which
allows the existing sysfs interface that people are used to and familiar with to
be used with it.  That also allows any existing cpufreq drivers to be used with
the new governor without any modifications, so if you are interested in how it
compares with "ondemand" and "conservative", apply the patch, build the new
governor into the kernel and echo "schedutil" to "scaling_governor" for your CPUs. :-)

[It cannot be made the default cpufreq governor ATM (for a bit of safety), but
that can be changed easily enough if someone wants to.]

Further, it is a "sampling governor" on the surface, but this really is not a
hard requirement.  In fact, it is quite straightforward to notice that util and
max are used directly as obtained from the scheduler without any sampling.  If
my understanding of the relevant CFS code is correct, util already contains
contributions form what happened in the past, so it should be fine to use it as
provided.

The sampling rate really plays the role of a rate limit for frequency updates.
The current code rather needs that because of the way it updates the CPU frequency
(from a work item run in process context), but if (at least some) cpufreq drivers
are taught to update the frequency "on the fly", it should be possible to dispense
with the sampling.  Of course, we still may find that rate limitting CPU
frequency changes is generally useful, but there may be special "emergency"
updates from the scheduler that will be reacted to immediately without
waiting for the whole "sampling period" to pass, for example.

Moreover, the new governor departs from the "let's code for the most complicated
case and the simpler ones will be handled automatically" approach that seems to
have been used throughout cpufreq, as it explicitly makes the "one CPU per cpufreq
policy" case special.  In that case, the values of util and max are not even
stored in the governor's data structures, but used immediately.  That allows it
to reduce the extra overhead from itself when possible.

Finally, but not least importantly, the new governor is completely generic.  It
doesn't depend on any system-specific or architecture-specific magic (other than
the policy sharing on systems where groups of CPUs have to be handled together)
to get the job done.  Thus it may be possible to use it as a base line for more
sophisticated frequency scaling solutions.

That last bit may be particularly important for systems where the only source
of information on the available frequency+voltage configurations of the CPUs
is something like ACPI tables and there is no information on the respective
cost of putting the CPUs into those configurations in terms of energy (and
no information on how much energy is consumed in the idle states available
on the given system).  With so little information on the "power topology" of
the system, so to speak, using the "frequency follows the utilization" rule
may simply be as good as it gets.  Even then (or maybe especially in those
cases), the frequency scaling mechanism should be reasonably lightweight and
effective, if possible, and this governor indicates that, indeed, that should
be possible to achieve.

There are two way in which this can be taken further.  The first, quite
obvious, one is to make it possible for cpufreq drivers to provide a method
for switching frequencies from interrupt context so as to avoid the need to
use the process-context work items for that, where possible.  The second one,
depending on the former, would be to try to eliminate the sampling rate and
simply update the frequency whenever the utilization changes and see how far
that would take us.  In addition to that, one may want to play with the
frequency selection formula (eg. to make it more or less aggressive etc).

The patch is on top of the linux-next branch of the linux-pm.git tree (that
should be part of the tomorrow's linux-next if all goes well), but it should
also apply on top of the pm-cpufreq-test branch in that tree (which only
contains changes related to cpufreq governors).

Please let me know what you think.

Thanks,
Rafael
