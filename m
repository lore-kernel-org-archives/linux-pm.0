From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
 Async suspend-resume patch w/ rwsems)
Date: Mon, 14 Dec 2009 10:21:38 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912141015240.26135__49758.1916781657$1260815054$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912091729530.2672-100000@iolanthe.rowland.org>
	<200912121848.33062.rjw@sisk.pl>
	<alpine.LFD.2.00.0912121049390.3526@localhost.localdomain>
	<200912122334.08367.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912122334.08367.rjw@sisk.pl>
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
> One solution that we have discussed on linux-pm is to start a bunch of async
> threads searching for async devices that can be suspended and suspending
> them (assuming suspend is considered) out of order with respect to dpm_list.

Ok, guys, stop the crazy.

That's another of those "ok, that's just ttoally stupid and clearly too 
complex" ideas that I would never pull.

I should seriously suggest that people just stop discussing architectural 
details on the pm list if they all end up being this level of crazy.

The sane thing to do is to just totally ignore the async layer on PCI 
bridges and other things that only have a late-suspend/early-resume thing. 
No need for the above kind of obviously idiotic crap.

However, my point was really that we wouldn't even have _needed_ that kind 
of special case if we had just decided to let the subsystems do it. But 
whatever. At worst, the PCI layer can even just mark such devices with 
just late/early suspend/resume as being asynchronous, even though that 
ends up resulting in some totally pointless async work that doesn't do 
anything.

But please guys - reign in the crazy ideas on the pm list. It's not like 
our suspend/resume has gotten so stable as to be boring, and we want it to 
become unreliable again.

			Linus
