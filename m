From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/3] [idled]: Idle Cycle Injector for power
	capping
Date: Thu, 15 Apr 2010 09:51:26 +0200
Message-ID: <1271317886.32749.69.camel__21846.6452243321$1271318002$gmane$org@laptop>
References: <20100413234902.29004.41655.stgit@bumblebee1.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100413234902.29004.41655.stgit@bumblebee1.mtv.corp.google.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Salman <sqazi@google.com>
Cc: dawnchen@google.com, csadler@google.com, linux-kernel@vger.kernel.org, ranjitm@google.com, kenchen@google.com, linux-pm@lists.linux-foundation.org, mingo@elte.hu, akpm@linux-foundation.org, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2010-04-13 at 17:08 -0700, Salman wrote:
> As we discussed earlier this year, Google has an implementation that it
> would like to share.  I have finally gotten around to porting it to
> v2.6.33 and cleaning up the interfaces.  It is provided in the following
> messages for your review.  I realize that when we first discussed this
> idea, a lot of ideas were presented for enhancing it.  Thanks alot for
> your suggestions.  I haven't gotten around to implementing any of them.

.33 is way too old to submit patches against.

That said, I really really dislike this approach, I would much rather
see it tie in with power aware scheduling.
