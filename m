From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 0/4] Rework disabling of interrupts
 during suspend-resume
Date: Thu, 5 Mar 2009 15:44:22 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0903051542270.19207@localhost.localdomain>
References: <200902221837.49396.rjw@sisk.pl> <200903012321.40328.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903012321.40328.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Sun, 1 Mar 2009, Rafael J. Wysocki wrote:
> 
> The following patches modifiy the way in which we handle disabling interrupts
> during suspend and enabling them during resume.  They also change the ordering
> of the core suspend and hibernation code.

Side note - I've tested them on the EeePC that had trouble resuming due to 
interrupt timings, and it suspends and resumes fine with these patches 
(modulo some new X problems, but that's what I get for living with 
Fedora-11 testing).

Of course, it also suspends and resumes without them, since the CPU "cli" 
was sufficient for that machine, and it doesn't have any ACPI issues. But 
it's still an ack that at least nothing breaks that I can tell.

		Linus
