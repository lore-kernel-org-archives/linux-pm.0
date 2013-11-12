From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC][PATCH v5 00/14] sched: packing tasks
Date: Tue, 12 Nov 2013 23:14:05 +0000
Message-ID: <42638CC1-ACC7-4330-A4F4-D78C88BE8155@arm.com>
References: <1382097147-30088-1-git-send-email-vincent.guittot@linaro.org> <CAHkRjk69GNYtLGBSWCNcsCzkBHywKrD0qQQbNkJRpMbcdsCPyw@mail.gmail.com> <20131111163630.GD26898@twins.programming.kicks-ass.net> <52810851.4090907@linux.intel.com> <20131111181805.GE29572@arm.com> <52825BE9.2080605@linux.intel.com>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:56379 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757316Ab3KLXOI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Nov 2013 18:14:08 -0500
In-Reply-To: <52825BE9.2080605@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Paul Turner <pjt@google.com>, Morten Rasmussen <Morten.Rasmussen@arm.com>, Chris Metcalf <cmetcalf@tilera.com>, Tony Luck <tony.luck@intel.com>, "alex.shi@intel.com" <alex.shi@intel.com>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, linaro-kernel <linaro-kernel@lists.linaro.org>, "len.brown@intel.com" <len.brown@intel.com>, "l.majewski@samsung.com" <l.majewski@samsung.com>, Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul McKenney <paulmck@linux.vnet.ibm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 12 Nov 2013, at 16:48, Arjan van de Ven <arjan@linux.intel.com> wrot=
e:
> On 11/11/2013 10:18 AM, Catalin Marinas wrote:
>> The ordering is based on the actual C-state, so a simple way is to w=
ake
>> up the CPU in the shallowest C-state. With asymmetric configurations
>> (big.LITTLE) we have different costs for the same C-state, so this w=
ould
>> come in handy.
>=20
> btw I was considering something else; in practice CPUs will be in the=
 deepest state..
> ... at which point I was going to go with some other metrics of what =
is best from a platform level

I agree, other metrics are needed.  The problem is that we currently
only have (relatively, guessed from the target residency) the cost of
transition from a C-state to a P-state (for the latter, not sure which)=
=2E
But we don=92t know what the power (saving) on that C-state is nor the =
one=20
at a P-state (and vendors reluctant to provide such information). So th=
e=20
best the scheduler can do is optimise the wake-up cost and blindly assu=
me=20
that deeper C-state on a CPU is more efficient than lower P-states on t=
wo=20
other CPUs (or the other way around).

If we find a good use for such metrics in the scheduler, I think the
vendors would be more open to providing at least some relative (rather
than absolute) numbers.

Catalin