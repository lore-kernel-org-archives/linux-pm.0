From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/6] cgroup_freezer: fix freezer->state
 setting bug in freezer_change_state()
Date: Mon, 5 Sep 2011 03:11:39 +0900
Message-ID: <20110904181139.GA9807__34569.1716568128$1315159964$gmane$org@htj.dyndns.org>
References: <1314988070-12244-1-git-send-email-tj@kernel.org>
	<1314988070-12244-2-git-send-email-tj@kernel.org>
	<20110904180206.GA28520@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110904180206.GA28520@redhat.com>
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

On Sun, Sep 04, 2011 at 08:02:06PM +0200, Oleg Nesterov wrote:
> Cough. Now it doesn't look right to me ;)
> 
> If the user write "FROZEN" into the control file, we should not
> turn the CGROUP_FROZEN state into CGROUP_FREEZING. Probably this
> is harmless, but this looks wrong and this doesn't match the
> current behaviour, user-visible change.

It's not user-visible as the state is always updated before shown to
userland.  If we're gonna be re-priming freezing on each FROZEN write,
resetting the state to freezing to force state re-calculation is
logical thing to do.

Thanks.

-- 
tejun
