From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 1/6] cgroup_freezer: fix freezer->state
	setting bug in	freezer_change_state()
Date: Sun, 4 Sep 2011 20:20:19 +0200
Message-ID: <20110904182019.GA29525__1878.35356123305$1315160675$gmane$org@redhat.com>
References: <1314988070-12244-1-git-send-email-tj@kernel.org>
	<1314988070-12244-2-git-send-email-tj@kernel.org>
	<20110904180206.GA28520@redhat.com>
	<20110904181139.GA9807@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110904181139.GA9807@htj.dyndns.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>
Cc: containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, paul@paulmenage.org
List-Id: linux-pm@vger.kernel.org

On 09/05, Tejun Heo wrote:
>
> On Sun, Sep 04, 2011 at 08:02:06PM +0200, Oleg Nesterov wrote:
> > Cough. Now it doesn't look right to me ;)
> >
> > If the user write "FROZEN" into the control file, we should not
> > turn the CGROUP_FROZEN state into CGROUP_FREEZING. Probably this
> > is harmless, but this looks wrong and this doesn't match the
> > current behaviour, user-visible change.
>
> It's not user-visible as the state is always updated before shown to
> userland.

Ah, indeed, thanks.

OK.

So, the only proble I can see is that update_if_frozen() can hit
BUG_ON(nfrozen > 0), but this is off-topic.

I think this patch is correct.

Oleg.
