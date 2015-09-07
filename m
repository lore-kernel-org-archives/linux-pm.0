From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Energy Aware Scheduling and Power Management LPC microconference summary
Date: Mon, 7 Sep 2015 23:32:34 +0200
Message-ID: <CAJZ5v0iZeuSMWYBKa4Mv2YvZZrubBTvG7XkHngR8L1j-Tj7YZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:38373 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbbIGVcg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2015 17:32:36 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>

Hi All,

After the Energy Aware Scheduling and Power Management microconference
at the LPC I and Morten prepared a summary of it  for the LPC readout session.
There was not enough time to present the whole of it, though, so I promised
to send it out, but then got distracted by urgent stuff and only got back to it
today.  It still is relevant in my view, so here it goes.

In addition to the below, the most important takeaway from the EAS+PM
microconference for both me and Morten was likely that more meetings
like that would be good to have, so we're considering organizing a PM
Summit next year.  One of the candidate time frames is along with the
ELC in April.  The other is at the Kernel Summit in October/November.

Please let me know what you think.

Thanks,
Rafael


---
Thursday

Modern systems tend to be more and more hierarchical in nature (power
domains etc.), but the existing CPU PM frameworks have problems with
taking that into account.

There are attempts to address this issue.  For example, the new version
6 of ACPI provides a way to describe hierarchies of CPU idle states that
in principle can be used for this purpose, but how to use that information
in the kernel is under discussion.  More discussion to happen.

There is a proposal from Linaro to extend the existing device PM framework
to cover CPU hierarchies that has been presented during the session.
Everybody acknowledged the problem and that it should be addressed and the
proposed approach does not appear to be objectionable (at the high level).
Patches are in the works at an RFC stage, to be worked on going forward.

The requisite topology information need to come from somewhere like
ACPI or a Device Tree.  A proposal of new DT bindings for this purpose
has been presented and discussed.  There were no major objections against
it, but more discussion is needed.

Also discussed was the problem of identifying possible wakeup sources
for system sleep states (suspend-to-RAM).  The kernel needs to know which
devices can wake up the system from sleep so as to allow user space to
configure them accordingly.  That information has to be provided in some
way and if it cannot be retrieved from devices themselves, the firmware
has to provide it.  There is no good way to do it in DT, more discussion
is needed.  Platforms handle wakeup interrupts inconsistently and that
needs to be carified and unified.  Work in progress.

Firday

The energy aware scheduling is a way to combine the decisions made by
the CPU scheduler and CPU PM governors (cpufreq, cpuidle) to achieve
consistency and ultimately to bring it an energy model to guide those
decisions.

There is a patchset implementing the idea in the works for some time,
a few bits from it have already been merged (per-task utilization
tracking and frequency invariant utilization tracking).

The energy aware scheduling patchset was discussed.  There is general
agreement on the approach.  The patchset needs to be split into smaller
bits easier to handle.  Those will be merged when they mature.

Related to that is a scheduler-driven frequency scaling propsal.
The idea is for the scheduler to play the role of a CPU frequency
governor, possibly taking the EAS bits into account.  Gaps have been
indentified in the cpufreq framework that need to be closed to make
it play nicer with the scheduler (locking, cpufreq-provided topology
information needs to agree with scheduling groups, an iterface to
change frequency asynchronously).  Those gaps will be worked on
going forward.

There was a discussion about possibly synchronizing the management
of performance states accross different system components (eg. GPUs
and CPUs).  More discussion is needed.

Some system use hardware-based peformance control.  The way it works
on recent Intel systems has been presented and discussed.  It is not
really clear how much those systems can benefit from the EAS-based
approach and in what way.  More discussion to happen.
