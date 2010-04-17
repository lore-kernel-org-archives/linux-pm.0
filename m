From: tytso@mit.edu
Subject: Re: [PATCH 0/3] [idled]: Idle Cycle Injector for power
	capping
Date: Sat, 17 Apr 2010 13:08:08 -0400
Message-ID: <20100417170808.GE32634__19827.9423443184$1271524260$gmane$org@thunk.org>
References: <20100413234902.29004.41655.stgit@bumblebee1.mtv.corp.google.com>
	<1271317886.32749.69.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1271317886.32749.69.camel@laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Salman <sqazi@google.com>, akpm@linux-foundation.org, dawnchen@google.com, csadler@google.com, linux-kernel@vger.kernel.org, ranjitm@google.com, kenchen@google.com, linux-pm@lists.linux-foundation.org, mingo@elte.hu, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 15, 2010 at 09:51:26AM +0200, Peter Zijlstra wrote:
> On Tue, 2010-04-13 at 17:08 -0700, Salman wrote:
> > As we discussed earlier this year, Google has an implementation that it
> > would like to share.  I have finally gotten around to porting it to
> > v2.6.33 and cleaning up the interfaces.  It is provided in the following
> > messages for your review.  I realize that when we first discussed this
> > idea, a lot of ideas were presented for enhancing it.  Thanks alot for
> > your suggestions.  I haven't gotten around to implementing any of them.
> 
> .33 is way too old to submit patches against.

But it's not too old for review purposes; as Salman said, they were
sent to LKML for comments and review.  I think it's well understood
that when these patches are ready to be merged, they need to be
submitted right before the merge window opens, against a recent -rc
kernel.

					- Ted
