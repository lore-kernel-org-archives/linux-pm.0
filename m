From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 0/2] Rework disabling of interrupts
 during suspend-resume
Date: Sun, 22 Feb 2009 15:02:31 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0902221500030.3111@localhost.localdomain>
References: <200902221837.49396.rjw@sisk.pl> <m1skm6cd3z.fsf@fess.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <m1skm6cd3z.fsf@fess.ebiederm.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Sun, 22 Feb 2009, Eric W. Biederman wrote:
> 
> How does this sync with the ACPI requirement that the it's late suspend MUST
> happen with irqs disabled?

All the system device suspend and the actual CPU power-off still happens 
with CPU interrupts disabled.

It's just that the regular two-phase device suspend code now runs first 
with interrupts enabled (the regular "->suspend()" callback), and then the 
second phase runs with the CPU still having interrupts on (and taking 
timer interrupts), but with the actual device interrupts disabled.

			Linus
