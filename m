From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [3/11] issue 3: No understanding of potential cpu capacity
Date: Tue,  7 Jan 2014 16:19:39 +0000
Message-ID: <1389111587-5923-4-git-send-email-morten.rasmussen@arm.com>
References: <1389111587-5923-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1389111587-5923-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, markgross@thegnar.org, vincent.guittot@linaro.org, catalin.marinas@arm.com, morten.rasmussen@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

To minimize energy it may sometimes be better to put waking tasks on
partially loaded cpus instead of powering up more cpus (particularly if
it implies powering up a new cluster/group of cpus with associated
caches). To make that call, information about the potential spare cycles
on the busy cpus is required.

Currently, the CFS scheduler has no knowledge about frequency scaling.
Frequency scaling governors generally try to match the frequency to
the load, which means that the idle time has no absolute meaning. The
potential spare cpu capacity may be much higher than indicated by the
idle time if the cpu is running at a low P-state.

The energy trade-off may justify putting another task on a loaded cpu
even if it causes a change to a higher P-state to handle the extra load.
Related issues are frequency (and cpu micro architecture) invariant task
load and power topology information, which are both needed to enable the
scheduler for energy-aware task placement. This is covered in more
detail in issue 5.

The potential cpu capacity cannot be assumed to be constant as thermal
management may restrict the usage of high performance P-states
dynamically.
