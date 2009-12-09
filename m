From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates
	for 2.6.33)
Date: Wed, 9 Dec 2009 17:27:13 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912091722310.2672-100000__9944.62536550618$1260397690$gmane$org@iolanthe.rowland.org>
References: <200912092256.45872.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912092256.45872.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 9 Dec 2009, Rafael J. Wysocki wrote:

> > I don't like that because it introduces "artificial" dependencies: It 
> > makes B depend on all the preceding synchronous suspends, even totally 
> > unrelated ones.  But yes, it would work.
> 
> Well, unfortunately, it wouldn't, because (at least in the context of my last
> patch) the core would release the rwsems as soon as your suspend had
> returned.  So you'd have to make your suspend wait for the async thread and
> that would make it pointless.  So scratch that, it wasn't a good idea at all.
> 
> This leaves us with basically two options, where the first one is to use
> rwsems in a way that you've proposed (with iterating over children), and the
> second one is to use completions.  In my opinion rwsems don't give us any
> advantage in this case, so I'd very much prefer to use completions.

If you really want to add support for async suspend constraints, then 
completions are clearer than rwsems.  If you don't care (and it's 
unlikely that anyone will need them in the near future) then you might 
as well stick with the current rwsem implementation and avoid iterating 
over children.

Alan Stern
