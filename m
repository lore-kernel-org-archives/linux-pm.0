From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
 Async suspend-resume patch w/ rwsems)
Date: Mon, 14 Dec 2009 16:10:11 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912141609020.14385__22693.3323815048$1260835870$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912091729530.2672-100000@iolanthe.rowland.org>
	<200912142311.31658.rjw@sisk.pl>
	<alpine.LFD.2.00.0912141416040.26135@localhost.localdomain>
	<200912150018.11837.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912150018.11837.rjw@sisk.pl>
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



On Tue, 15 Dec 2009, Rafael J. Wysocki wrote:
> 
> Because the PCI bridges are not the only case where it matters (I'd say they
> are really a corner case).  Basically, any two async devices separeted by a
> series of sync ones are likely not to be suspended (or resumed) in parallel
> with each other, because the parent is usually next to its children in dpm_list.

Give a real example that matters.

Really. 

How hard can it be to understand: KISS. Keep It Simple, Stupid.

I get really tired of this whole stupid async discussion, because you're 
overdesigning it.

To a first approximation, THE ONLY THING THAT MATTERS IS USB.

		Linus
