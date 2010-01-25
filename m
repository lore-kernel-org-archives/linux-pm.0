From: Frans Pop <elendil@planet.nl>
Subject: Warnings about tasks on CPU 1 during STR
Date: Mon, 25 Jan 2010 05:42:07 +0100
Message-ID: <201001250542.08642.elendil__36857.729839585$1264394641$gmane$org@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

With 2.6.33-rc5 during suspend to RAM I'm getting a bunch of warnings
I've not seen with earlier kernel versions:

PM: late suspend of devices complete after 28.784 msecs
ACPI: Preparing to enter system sleep state S3
Disabling non-boot CPUs ...
CPU 1 is now offline
SMP alternatives: switching to UP code
Task events/1 (pid = 10) is on cpu 1 (state = 1, flags = 84208040)
Task khelper (pid = 11) is on cpu 1 (state = 1, flags = 80208040)
Task sync_supers (pid = 77) is on cpu 1 (state = 1, flags = 80208040)
Task bdi-default (pid = 79) is on cpu 1 (state = 2, flags = 80a15040)
Task kblockd/1 (pid = 81) is on cpu 1 (state = 1, flags = 84208040)
[...]
Task pm-suspend (pid = 29782) is on cpu 1 (state = 2, flags = 414000)
Extended CMOS year: 2000
Back to C!

All the "Task X is on cpu 1" messages (76 in total) are new. Bug or
intentional? As it is a warning, I suspect a bug.

Cheers,
FJP
