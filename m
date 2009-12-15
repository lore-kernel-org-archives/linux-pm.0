From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
	Async suspend-resume patch w/ rwsems)
Date: Tue, 15 Dec 2009 12:14:10 +0100
Message-ID: <200912151214.10980.rjw__26513.8549767018$1260876008$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0912091729530.2672-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.0912141609020.14385@localhost.localdomain>
	<alpine.LFD.2.00.0912141610460.14385@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0912141610460.14385@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 15 December 2009, Linus Torvalds wrote:
> 
> On Mon, 14 Dec 2009, Linus Torvalds wrote:
> > 
> > I get really tired of this whole stupid async discussion, because you're 
> > overdesigning it.
> 
> Btw, this is important. I'm not going to pull even your _current_ async 
> stuff if you can't show that you fundamentally UNDERSTAND this fact.

What fact?  The only thing that matters is USB?  For resume, it is.  For
suspend, it clearly isn't.

> Stop making up idiotic complex interfaces. Look at my one-liner patch, and 
> realize that it gets you 99% there - the 99% that matters.

I said I was going to use it, but I don't think that's going to be sufficient.

[BTW, I'm not sure what you want to achieve by insulting me.  Either you may
want to scare me, but I'm not scared, or you may want to try to make me so
disgusted that I'll just give up and back off, but this is not going to happen
either.]

Insults aside, I'm going to make some measurements to see how much time we can
save.

Rafael
