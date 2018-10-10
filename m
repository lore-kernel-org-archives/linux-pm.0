From: Matthew Garrett <matthewgarrett@google.com>
Subject: Expose all known Intel DPTF policies
Date: Wed, 10 Oct 2018 01:30:05 -0700
Message-ID: <20181010083007.239938-1-matthewgarrett@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Intel's Dynamic Platform and Thermal Framework is a combination
firmware/OS framework for allowing userland to implement more complex
thermal policies in conjunction with the platform firmware. The rough
gist is that the firmware exposes a set of information describing the
relationships between various heat generating and heat removing
components in the system, the OS makes a reasonable decision about what
sort of policy will work best given the constraints the system is
currently operating under and passes that decision back to the firmware,
and the firmware does some magic (potentially including reprogramming
various CPU MSRs) to match the OS policy. Depending on the policy, the
OS may then be responsible for ensuring that the system stays within the
appropriate thermal envelope.

Linux already has a driver that exposes the firmware interface for
setting the policy, but it's somewhat broken - it only exposes a very
small subset of the defined policies, and most new systems don't
intersect with the exposed ones (strangely, support for some policies
was actively removed in 31908f45a583e8f21db37f402b6e8d5739945afd). It
also doesn't actually /work/ on any new systems, since the PASSIVE_1
policy seems to have been replaced by the PASSIVE_2 policy and therefore
it's impossible to actually trigger a new UUID write.

The consequence of this right now is that various new systems (such as
most current Thinkpads) default to a safe policy that throttles the CPU
at a low temperature, dramatically reducing system performance. Since
Linux provides no mechanism to set any of the other policies the
platform supports, users are stuck. This patchset adds all the UUIDs
I've been able to find from scraping various ACPI tables, and fixes the
mode setting in order to make it possible to actually set the new modes.
It should be noted that this is nowhere near an actual solution - doing
this properly requires appropriate userspace management tooling, and
Intel haven't documented most of the ACPI information required to make
it possible to write such tooling. However, this is a first step in
making it possible to do that work.
