From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Thu, 6 May 2010 21:28:30 +0200
Message-ID: <201005062128.31068.rjw__31495.9044023$1273174081$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1005061110090.1708-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1005061110090.1708-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 06 May 2010, Alan Stern wrote:
> On Tue, 27 Apr 2010, [UTF-8] Arve Hj=C3=B8nnev=C3=A5g wrote:
> =

> > +static void suspend_worker(struct work_struct *work)
> > +{
> > +	int ret;
> > +	int entry_event_num;
> > +
> > +	enable_suspend_blockers =3D true;
> > +	while (!suspend_is_blocked()) {
> > +		entry_event_num =3D current_event_num;
> > +
> > +		if (debug_mask & DEBUG_SUSPEND)
> > +			pr_info("suspend: enter suspend\n");
> > +
> > +		ret =3D pm_suspend(requested_suspend_state);
> > +
> > +		if (debug_mask & DEBUG_EXIT_SUSPEND)
> > +			pr_info_time("suspend: exit suspend, ret =3D %d ", ret);
> > +
> > +		if (current_event_num =3D=3D entry_event_num)
> > +			pr_info("suspend: pm_suspend returned with no event\n");
> > +	}
> > +	enable_suspend_blockers =3D false;
> > +}
> =

> Here's a completely new issue.  When using opportunistic suspends on an
> SMP system, it could happen that the system gets a wakeup event and
> this routine starts running again before the event's IRQ handler has
> finished (or has enabled a suspend blocker).  The system would =

> re-suspend too soon.

This routine will be run from a freezable workqueue.

Rafael
