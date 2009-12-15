From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
 Async suspend-resume patch w/ rwsems)
Date: Mon, 14 Dec 2009 16:11:41 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912141610460.14385__25093.7701006935$1260835954$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912091729530.2672-100000@iolanthe.rowland.org>
	<200912142311.31658.rjw@sisk.pl>
	<alpine.LFD.2.00.0912141416040.26135@localhost.localdomain>
	<200912150018.11837.rjw@sisk.pl>
	<alpine.LFD.2.00.0912141609020.14385@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0912141609020.14385@localhost.localdomain>
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
> I get really tired of this whole stupid async discussion, because you're 
> overdesigning it.

Btw, this is important. I'm not going to pull even your _current_ async 
stuff if you can't show that you fundamentally UNDERSTAND this fact.

Stop making up idiotic complex interfaces. Look at my one-liner patch, and 
realize that it gets you 99% there - the 99% that matters.

		Linus
