From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpuidle: poll_state: Revise loop termination condition
Date: Sat, 10 Nov 2018 13:50:01 -0800
Message-ID: <001101d4793f$56535770$02fa0650$@net>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
References: 7Sblgyz0iivID7SbmgCnar
In-Reply-To: 7Sblgyz0iivID7SbmgCnar
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Peter Zijlstra' <peterz@infradead.org>, 'LKML' <linux-kernel@vger.kernel.org>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Linux PM' <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2018.10.02 14:51 Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> If need_resched() returns "false", breaking out of the loop in
> poll_idle() will cause a new idle state to be selected, so in fact
> usually it doesn't make sense to spin in it longer than the target
> residency of the second state.  [Note that the "polling" state is
> used only if there is at least one "real" state defined in addition
> to it.]  On the other hand, breaking out of it early (say in case
> the next state is disabled) shouldn't hurt as it is polling anyway.

While I agree that it is polling anyway, this change can add significant
burden when debugging and trace is enabled for cpu_idle, if idle state 0
is used often.

For example: Phoronix dbench test, 96 clients: 900 second trace:

Kernel 4.20-rc1:
idle state 0 entry exits: 686,724
Does trace being enabled effect the system under test: Yes.

Kernel 4.20-rc1 with this patch reverted:
idle state 0 entry exits: 66,185
Does trace being enabled effect the system under test: No, or minimal.

... Doug
