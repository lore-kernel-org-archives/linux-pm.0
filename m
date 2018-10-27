From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [RFC/RFT][PATCH v2] cpuidle: New timer events oriented governor for tickless systems
Date: Fri, 26 Oct 2018 23:37:24 -0700
Message-ID: <001201d46dbf$88339510$989abf30$@net>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
References: FyDdgD8Nty5tHFyDfgBIL9
In-Reply-To: FyDdgD8Nty5tHFyDfgBIL9
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Peter Zijlstra' <peterz@infradead.org>, 'LKML' <linux-kernel@vger.kernel.org>, 'Frederic Weisbecker' <frederic@kernel.org>, 'Mel Gorman' <mgorman@suse.de>, 'Giovanni Gherdovich' <ggherdovich@suse.cz>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Linux PM' <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

This is just for anybody else trying to compile:

On 2018.10.26 02:12 Rafael J. Wysocki wrote:

> The venerable menu governor does some thigns that are quite

Typo: thigns -> things

...[snip]...

> The patch should apply on top of 4.19, although I'm running it on
> top of my linux-next branch.

No, it uses "poll_time_limit" which was introduced in patch 1 of 6
[1] in that group of menu changes from October 2nd.

"[PATCH 1/6] cpuidle: menu: Fix wakeup statistics updates for polling state"

... Doug

[1] https://lkml.org/lkml/2018/10/3/42
