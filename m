From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 6/6] freezer: kill unused
	set_freezable_with_signal()
Date: Wed, 7 Sep 2011 00:53:32 +0900
Message-ID: <20110906155332.GF18425__18032.9381292269$1315324492$gmane$org@mtj.dyndns.org>
References: <1314988070-12244-1-git-send-email-tj@kernel.org>
	<1314988070-12244-7-git-send-email-tj@kernel.org>
	<20110904184626.GA30101@redhat.com>
	<20110905023315.GB9807@htj.dyndns.org>
	<20110905162012.GA4445@redhat.com>
	<20110906032846.GA18425@mtj.dyndns.org>
	<20110906151836.GA15568@redhat.com>
	<20110906152539.GA16899@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110906152539.GA16899@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, paul@paulmenage.org
List-Id: linux-pm@vger.kernel.org

Hello,

On Tue, Sep 06, 2011 at 05:25:39PM +0200, Oleg Nesterov wrote:
> On 09/06, Oleg Nesterov wrote:
> >
> > Yes, agreed. In this case I think it should be
> >
> > 	#define wait_event_freezable(wq, condition)				\
> > 	({									\
> > 		int __retval;							\
> > 		for (;;) {							\
> > 			__retval = wait_event_interruptible(wq, 		\
> > 					(condition) || freezing(current));	\
> > 			if (__retval || (condition))				\
> > 				break;						\
> > 			try_to_freeze();					\
> > 		}								\
> > 		__retval;							\
> > 	})
> >
> > __retval/ERESTARTSYS is only needed for kthreads which play with allow_signal(),
> > probably nobody should do this.
> 
> I meant, unless the caller plays with allow_signal(), it has all rights to do
> 
> 	if (wait_event_freezable(...))
> 		BUG();
> 
> This becomes correct with the code above.

Yeap, sure, w/ freezable_with_signal gone, the above should work fine.
Care to create a patch?

Thanks.

-- 
tejun
