From: Thomas Renninger <trenn@suse.de>
Subject: [SUBMIT REQUEST] cpupowerutils for linux-next
Date: Mon, 4 Apr 2011 15:10:56 +0200
Message-ID: <201104041510.56570.trenn__44484.738171059$1301922726$gmane$org@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: sfr@canb.auug.org.au
Cc: Greg Kroah-Hartman <gregkh@novell.com>, Andreas Herrmann <andreas.herrmann3@amd.com>, LKML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

this is about the recently announced cpupowerutils project
based on or say an enhancement of the well know
cpufrequtils project:
http://www.spinics.net/lists/cpufreq/msg02137.html

It's basically cpufrequtils with some cpuidle info additions
and the Intel only turbostat tool merged into it in a way
that it can easily get extended for other HW (and got extended
with some AMD facilities).

As there is tools/power/x86 for some time, it would be very
convenient to get cpupowerutils merged into linux-next (for now)
into the tools/power/cpupower directory:
Most of it is directly based on the cpufreq/cpuidle kernel
subsystem and the output gathered by it should be attached
to any CPU frequency/idle related kernel bug.

Dominik was so kind to add the stuff to his pcmcia git tree
as cpupowerutils branch.
Therefore, this can easily be added by pulling from:
git://git.kernel.org/pub/scm/linux/kernel/git/brodo/pcmcia-2.6.git cpupowerutils

Even the MAINTAINERS file got adjusted already (thanks!):
CPU POWER MONITORING SUBSYSTEM
M:      Dominik Brodowski <linux@dominikbrodowski.net>
M:      Thomas Renninger <trenn@suse.de>
S:      Maintained
F:      tools/power/cpupower


Stephen: I added lkml, linux-pm lists and kernel people I know
working in this area. Please tell me if you can/will just
pull this or whatever you need to make it happen.

Thanks,

     Thomas
