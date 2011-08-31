From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH pm-freezer 1/4] cgroup_freezer: fix
	freezer->state	setting bug in freezer_change_state()
Date: Wed, 31 Aug 2011 20:08:58 +0200
Message-ID: <20110831180858.GA10725__1359.01590479097$1314918770$gmane$org@redhat.com>
References: <20110831102100.GA2828@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110831102100.GA2828@mtj.dyndns.org>
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
Cc: linux-kernel@vger.kernel.org, Paul Menage <paul@paulmenage.org>, containers@lists.linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 08/31, Tejun Heo wrote:
>
> I'm in the process of moving and can only use a quite old laptop.  I
> tested compile but couldn't really do much else, so please proceed
> with caution.  Oleg, can you please ack the patches if you agree with
> the updated versions?

Everything looks fine. But I am already sleeping now ;)

Rafael, Tejun, I'll try to re-read 1-4 tomorrow. I do not expect I'll
find something interesting, just I am paranoid.

Looks like, 1/4 could have an additional note in the changelog, with
this patch we avoid the unnecessary try_to_freeze_cgroup() and this
looks like a win to me...

Oleg.
