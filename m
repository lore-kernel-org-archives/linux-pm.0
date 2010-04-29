From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 6/8] PM: Add suspend blocking work.
Date: Thu, 29 Apr 2010 23:08:22 +0200
Message-ID: <201004292308.22457.rjw@sisk.pl>
References: <1272429119-12103-1-git-send-email-arve@android.com>
	<201004282308.10751.rjw@sisk.pl>
	<20100429185851.GA13862@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100429185851.GA13862@redhat.com>
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
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday 29 April 2010, Oleg Nesterov wrote:
> On 04/28, Rafael J. Wysocki wrote:
> >
> > On Wednesday 28 April 2010, Tejun Heo wrote:
> > > On 04/28/2010 09:40 PM, Oleg Nesterov wrote:
> > > >> +int schedule_suspend_blocking_work(struct suspend_blocking_work *work)
> > > >> +{
> > > >> ...
> > > >> +	ret = schedule_work(&work->work);
> > > >
> > > > Off-topic. We should probably export keventd_wq to avoid the duplications
> > > > like this.
> > >
> > > Yeah, had about the same thought.  cmwq exports it so I didn't suggest
> > > it at this point but then again we don't really know whether or when
> > > that series is going in
> >
> > As soon as there are no major objections.  At least to my tree.
> >
> > > so it might be a good idea to make that change now.  Hmm...
> >
> > I'd rather like a follow-up patch changing that, if poss.
> 
> Confused. Rafael, do you mean you dislike this change now?

No, I'm fine with the change itself, but I wouldn't like to make the suspend
blockers patchset depend on something in a different tree.  If it's not the
case, I have no objections.

Rafael
