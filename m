From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Warnings about tasks on CPU 1 during STR
Date: Mon, 25 Jan 2010 13:50:59 +0100
Message-ID: <1264423859.4283.1725.camel@laptop>
References: <201001250542.08642.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001250542.08642.elendil@planet.nl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2010-01-25 at 05:42 +0100, Frans Pop wrote:
> With 2.6.33-rc5 during suspend to RAM I'm getting a bunch of warnings
> I've not seen with earlier kernel versions:
> 
> PM: late suspend of devices complete after 28.784 msecs
> ACPI: Preparing to enter system sleep state S3
> Disabling non-boot CPUs ...
> CPU 1 is now offline
> SMP alternatives: switching to UP code
> Task events/1 (pid = 10) is on cpu 1 (state = 1, flags = 84208040)
> Task khelper (pid = 11) is on cpu 1 (state = 1, flags = 80208040)
> Task sync_supers (pid = 77) is on cpu 1 (state = 1, flags = 80208040)
> Task bdi-default (pid = 79) is on cpu 1 (state = 2, flags = 80a15040)
> Task kblockd/1 (pid = 81) is on cpu 1 (state = 1, flags = 84208040)
> [...]
> Task pm-suspend (pid = 29782) is on cpu 1 (state = 2, flags = 414000)
> Extended CMOS year: 2000
> Back to C!
> 
> All the "Task X is on cpu 1" messages (76 in total) are new. Bug or
> intentional? As it is a warning, I suspect a bug.

http://lkml.org/lkml/2010/1/21/175
