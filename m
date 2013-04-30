From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 02/10] freezer: skip waking up tasks with
	PF_FREEZER_SKIP set
Date: Tue, 30 Apr 2013 19:15:01 +0200
Message-ID: <20130430171501.GB28944@redhat.com>
References: <1367271946-7239-1-git-send-email-ccross@android.com> <1367271946-7239-3-git-send-email-ccross@android.com> <20130430171059.GA28944@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130430171059.GA28944@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Cross <ccross@android.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, arve@android.com, Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, containers@redhat.com
List-Id: linux-pm@vger.kernel.org

On 04/30, Oleg Nesterov wrote:
>
> On 04/29, Colin Cross wrote:
> >
> > @@ -46,10 +46,10 @@ static int try_to_freeze_tasks(bool user_only)
> >  		todo = 0;
> >  		read_lock(&tasklist_lock);
> >  		do_each_thread(g, p) {
> > -			if (p == current || !freeze_task(p))
> > +			if (p == current || freezer_should_skip(p))
> >  				continue;
> >
> > -			if (!freezer_should_skip(p))
> > +			if (freeze_task(p))
> >  				todo++;
>
> What if we race with freezer_count() ?
>
> try_to_freeze_tasks() can wrongly succeed leaving the running task
> unfrozen, no?

Ah, no, sorry for noise.

Oleg.
