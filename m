From: Andi Kleen <andi@halobates.de>
Subject: Re: [PATCH 4/8] PM: suspend_block: Add debugfs file
Date: Tue, 04 May 2010 13:16:40 +0200
Message-ID: <87mxwf533b.fsf__2794.6523194716$1272984304$gmane$org@basil.nowhere.org>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<1272667021-21312-2-git-send-email-arve@android.com>
	<1272667021-21312-3-git-send-email-arve@android.com>
	<1272667021-21312-4-git-send-email-arve@android.com>
	<1272667021-21312-5-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1272667021-21312-5-git-send-email-arve@android.com> (Arve
	=?iso-8859-1?Q?Hj=F8nnev=E5g's?= message of "Fri, 30 Apr 2010 15:36:57
	-0700")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Tejun Heo <tj@kernel.org>, Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
List-Id: linux-pm@vger.kernel.org

Arve Hj=F8nnev=E5g <arve@android.com> writes:
>  =

> +static int suspend_blocker_stats_show(struct seq_file *m, void *unused)
> +{
> +	unsigned long irqflags;
> +	struct suspend_blocker *blocker;
> +
> +	seq_puts(m, "name\tactive\n");
> +	spin_lock_irqsave(&list_lock, irqflags);
> +	list_for_each_entry(blocker, &inactive_blockers, link)
> +		seq_printf(m, "\"%s\"\t0\n", blocker->name);
> +	list_for_each_entry(blocker, &active_blockers, link)
> +		seq_printf(m, "\"%s\"\t1\n", blocker->name);
> +	spin_unlock_irqrestore(&list_lock, irqflags);

Could you report the pid here too? =


The name set by the application might be meaningless or duplicated.

-Andi

-- =

ak@linux.intel.com -- Speaking for myself only.
