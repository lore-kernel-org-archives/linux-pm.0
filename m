From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
 Async suspend-resume patch w/ rwsems)
Date: Sat, 12 Dec 2009 10:54:50 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912121049390.3526@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912091729530.2672-100000@iolanthe.rowland.org>
	<200912120048.46180.rjw@sisk.pl>
	<alpine.LFD.2.00.0912111552330.3526@localhost.localdomain>
	<200912121848.33062.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912121848.33062.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Sat, 12 Dec 2009, Rafael J. Wysocki wrote:
> 
> I'd like to put it into my tree in this form, if you don't mind.

This version still has a major problem, which is not related to 
completions vs rwsems, but simply to the fact that you wanted to do this 
at the generic device layer level rather than do it at the actual 
low-level suspend/resume level.

Namely that there's no apparent sane way to say "don't wait for children".

PCI bridges that don't suspend at all - or any other device that only 
suspends in the 'suspend_late()' thing, for that matter - don't have any 
reason what-so-ever to wait for children, since they aren't actually 
suspending in the first place. But you make them wait regardless, which 
then serializes things unnecessarily (for example, two unrelated USB 
controllers).

And no, making _everything_ be async is _not_ the answer.

			Linus
