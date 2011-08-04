From: Len Brown <lenb@kernel.org>
Subject: Re: [GIT PULL] idle patches for Linux 3.1
Date: Thu, 04 Aug 2011 01:03:40 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1108040030550.29492__27868.5822537684$1312434382$gmane$org@x980>
References: <alpine.LFD.2.02.1108031627060.19398@x980>
	<CA+55aFxikiro4cEwGEOMCGUswyPsaAwyspP1cFUviJ5OUKOZJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <CA+55aFxikiro4cEwGEOMCGUswyPsaAwyspP1cFUviJ5OUKOZJw@mail.gmail.com>
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> On Wed, Aug 3, 2011 at 10:54 AM, Len Brown <lenb@kernel.org> wrote:
> >
> > please pull from:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-idle-2.6.git idle-release
> 
> As with the APEI tree, the commits are all recent and cannot have been
> in -next.  It's the last day before the merge window closes, please
> tell me why I should take this in this cycle at all?

I re-based this branch immediately before pushing
in order to add "Acked-by" annotations.

The cpuidle patches were in linux-next back in April.
But they were on a branch with other patches that got
deferred till 2012 b/c some folks were uneasy with
me deleting so much code so suddenly.  I cherry-picked
some simple ones here b/c IBM asked me to in order to
make their upcoming p-series cpuidle patches cleaner.

The mrst pmu.c driver is new.  MRST doesn't work without it.
Of course, if you don't have CONFIG_X86_MRST=y, you don't care.

Yes, this pull request is late, and if you skip it,
life will still go on.  You'll simply see the same
patches wating for you in 10 weeks.  On the other hand,
some developers will have a happier summer if these get upstream now,
and I'm here to support them if anything goes wrong.

thanks,
-Len
