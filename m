From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH 00/14] cpufreq: intel_pstate: Fixes, cleanups and optimizations
Date: Sun, 12 Mar 2017 23:29:24 -0700
Message-ID: <001301d29bc3$29c351c0$7d49f540$@net>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta16.telus.net ([209.171.16.89]:54199 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750801AbdCMG3a (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Mar 2017 02:29:30 -0400
References: n7NGc1Po4sVy3n7NIcDiMl
In-Reply-To: n7NGc1Po4sVy3n7NIcDiMl
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>
Cc: 'LKML' <linux-kernel@vger.kernel.org>, 'Linux PM' <linux-pm@vger.kernel.org>

On 2017.03.12 10:12 Rafael J. Wysocki wrote:

> This patch series fixes a couple of bugs in intel_pstate, cleans up the code in
> it somewhat and makes some changes targeted at overhead reductions.
>

If clean up and overhead reductions are being considered, is there any interest
in changing the PID controller to a P controller and eliminating the integral
and derivative code entirely?

Why? The application is not really best suited to a PID
(Proportional Integral Derivative) controller. 

Integral terms are normally used to null out accumulated errors. For example
position errors as a function of integrated velocity, where the overall
position is supposed to be time * nominal velocity, but the actual velocity
at any sample point is not perfect.

In signal processing, derivatives are difficult at the best of times, let alone
with the drastic sample time variations (anywhere from 10 milliseconds to 5 seconds)
experienced here. Myself, I can not think of a need for a derivative term anyhow.

Readers might note the old non-zero integral gain for the old methods used
with Atom processors (being eliminated in this patch set, see patch 2 of 14).
However that was due to the low proportional gain used and was needed to get
target pstates to tick up or down as it settled to some steady state value,
as otherwise and with a setpoint of 97 (which is what was being used at the
time), it would not. I'm saying the integral term was being used in way that
was not intended to overcome another issue. In that scenario, and at the very
least, the error term should have been cleared upon integration to the point
where the pstate ticked up or down as a result.

To be clear, I'm not talking about changing the proportional code at all,
but only about eliminating the integral and derivative code that has never
been used.

If there is interest, I'll prepare and submit a patch.

> Patch [1/14] is a regression fix, patch [2/14] can be regarded as a fix too,
>
> Patches [3-9/14] are cleanups mostly getting rid of unnecessary stuff.
>
> Patches [10-11/14] make changes to reduce the overhead of utilization update
> callbacks used in the active mode.
>
> Patches [12-14/14] make more cleanups on top of that.
>
> Refer to the changelogs for details.
