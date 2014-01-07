From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [2/11] issue 2: Energy-awareness for heterogeneous systems
Date: Tue,  7 Jan 2014 16:19:38 +0000
Message-ID: <1389111587-5923-3-git-send-email-morten.rasmussen@arm.com>
References: <1389111587-5923-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1389111587-5923-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, markgross@thegnar.org, vincent.guittot@linaro.org, catalin.marinas@arm.com, morten.rasmussen@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

While performance is non-deterministic with the mainline scheduler
(described in issue 6) it also leads to non-deterministic energy
consumption.  First step is to get performance right, but if we don't
keep energy in mind, heterogeneous systems will end up with high
performance and energy consumption.

To save energy low intensity workloads should not be scheduled on fast
cpus as these are generally less energy efficient. Audio playback is an
example where the performance offered by the slow cpus in todays
heterogeneous systems like ARM big.LITTLE is more than sufficient.

The mainline scheduler may schedule it on any cpu leading to
non-deterministic energy consumption. The energy expense on big (A15) is
3.63x little (A7) for Android mp3 audio playback on ARM TC2 (2xA15+3xA7)
when using just the A15s or just the A7s.

If we run multiple workloads at the same time, e.g. audio and
webbrowsing, both performance and energy is non-deterministic. Because
of audio we may even get poor webbrowsing performance and high energy
consumption at the same time.

Running that scenario on Android on ARM TC2 gives the following
execution times and energy measurements for 10 runs (normalized to avg):

Run     Exec    Energy
1       1.03    1.04
2       1.12    1.11    Worst energy
3       0.85    1.08
4       0.85    1.08    Best performance
5       0.94    1.06
6       1.01    0.78
7       0.90    0.63    Best performance/energy and best energy
8       1.22    1.08    Worst performance/energy and worst performance
9       0.94    1.08
10      1.14    1.07

Run 7 had a very good schedule as it led to both lowest energy and also
good performance at the same time. That is not generally the case. Run 2
is an example of a poor schedule where performance is 12% worse than
average and energy is 11% higher. Best performance in run 3 comes at the
cost of high energy.

While run 7 seems to be ideal from an energy-awareness point of view,
it may be disqualified by performance constraints. Hence, ideally the
performance level should be tunable.

Possible solution: We know that a simple heuristic that controls task
placement based on tracked load works rather well for most smartphone
workloads. However, realistic patterns exist that defeat this heuristic.
