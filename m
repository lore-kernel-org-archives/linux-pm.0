From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/4] cpuidle: define the enter function in the driver
 structure
Date: Fri, 06 Jul 2012 12:58:09 +0200
Message-ID: <4FF6C4C1.7030004@linaro.org>
References: <1341494608-16591-1-git-send-email-daniel.lezcano@linaro.org> <1341494608-16591-2-git-send-email-daniel.lezcano@linaro.org> <201207052238.44330.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <201207052238.44330.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linaro-dev@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On 07/05/2012 10:38 PM, Rafael J. Wysocki wrote:
> On Thursday, July 05, 2012, Daniel Lezcano wrote:
>> We have the state index passed as parameter to the 'enter' function.
>> Most of the drivers assign their 'enter' functions several times in
>> the cpuidle_state structure, as we have the index, we can delegate
>> to the driver to handle their own callback array.
>>
>> That will have the benefit of removing multiple lines of code in the
>> different drivers.
>=20
> Hmm. I suppose the cpuidle subsystem was designed the way it was for =
a reason.
> Among other things, this was to avoid recurrence in callbacks - pleas=
e see
> acpi_idle_enter_bm() for example.
>=20
> Now, if .enter() is moved to the driver structure, it will have to be=
 an
> all-purpose complicated routine calling itself recursively at least i=
n
> some cases.  I'm not quite convinced that would be an improvement.
>=20
> On the other hand, I don't see anything wrong with setting several ca=
llback
> pointers to the same routine.

Deepthi sent a few months ago a patch moving the per-cpu cpuidle_state
to a single structure stored in the driver. The drivers were modified
and cleanup to take into account this modification.

We saw some regressions like for example the 'disable' which were not
per cpu and has been moved to the cpuidle_state_usage (and IMHO it is a
workaround more than a real fix). And now we have new architectures
(tegra3, big.LITTLE) with different latencies per cpu. Logically we
should revert Deepthi's patches but from my POV, going back and forth i=
s
not a good solution (also we have to undo all modifications done in the
different drivers).

The main purpose of all these cleanup patches are to move out all
non-data information from the cpuidle_state structure in order to add a
new api which could be 'cpuidle_register_cpu_latency(int cpu, struct
cpuidle_latencies latencies)'.

=46or this specific patch, the 'enter' function for all the drivers is =
not
used [1] and one of the driver is about to use a single function [2]. S=
o
we have only one driver is a couple of functions for this which can be
replaced by an array of callbacks in the driver itself as we have the i=
ndex.

[1] http://lists.linaro.org/pipermail/linaro-dev/2012-June/012355.html
[2] http://lists.linaro.org/pipermail/linaro-dev/2012-June/012399.html


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
