From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
	during suspend-resume
Date: Mon, 23 Feb 2009 07:28:06 -0800
Message-ID: <m18wnx41h5.fsf__14667.9536243484$1235403071$gmane$org@fess.ebiederm.org>
References: <200902221837.49396.rjw@sisk.pl> <20090223094441.GM9582@elte.hu>
	<m1bpst77te.fsf@fess.ebiederm.org> <200902231203.09082.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902231203.09082.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Mon\, 23 Feb 2009 12\:03\:07 +0100")
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

>> I don't know where in the state machine this is getting called but
>> I would suggest doing this before we shutdown cpus.
>
> This is the plan.  In fact, I'm going to do this in the next patch after the
> $subject one has been tested and found acceptable.

Good to hear.  Then let's please get a version of the irq disable that calls
shutdown, so we can be certain we don't have hardware irqs in flight.

For the drivers it should not matter for clean cpu shutdown it will.

Eric
