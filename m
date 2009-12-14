From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
 Async suspend-resume patch w/ rwsems)
Date: Mon, 14 Dec 2009 14:43:35 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912141442180.26135__23047.6488978185$1260830675$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912091729530.2672-100000@iolanthe.rowland.org>
	<200912122334.08367.rjw@sisk.pl>
	<alpine.LFD.2.00.0912141015240.26135@localhost.localdomain>
	<200912142311.31658.rjw@sisk.pl>
	<alpine.LFD.2.00.0912141416040.26135@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0912141416040.26135@localhost.localdomain>
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



On Mon, 14 Dec 2009, Linus Torvalds wrote:
> 
> Here's an untested one-liner that has a 10-line comment.

Btw, when I say "untested", in this case I mean that it isn't even 
compile-tested. I haven't merged your other patches yet, so in my tree 
that 'async_suspend' flag doesn't even exist, and the patch I sent out 
definitely doesn't compile.

But it _might_ compile (and perhaps even work) in your tree.

		Linus
