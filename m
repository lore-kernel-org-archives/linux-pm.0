From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 1/3] [kidled]: introduce kidled.
Date: Wed, 14 Apr 2010 11:49:56 +0200
Message-ID: <87fx2y9xdn.fsf__34009.1104888872$1271238768$gmane$org@basil.nowhere.org>
References: <20100413234902.29004.41655.stgit@bumblebee1.mtv.corp.google.com>
	<20100414000823.29004.98991.stgit@bumblebee1.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100414000823.29004.98991.stgit@bumblebee1.mtv.corp.google.com>
	(Salman's message of "Tue, 13 Apr 2010 17:08:33 -0700")
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
Cc: ranjitm@google.com, peterz@infradead.org, linux-kernel@vger.kernel.org, csadler@google.com, kenchen@google.com, dawnchen@google.com, linux-pm@lists.linux-foundation.org, mingo@elte.hu, akpm@linux-foundation.org, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

Salman <sqazi@google.com> writes:
> +
> +static int proc_stats(struct ctl_table *table, int write,
> +		      void __user *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	int ret;
> +	unsigned long stats[3];
> +	int cpu = (int)((long)table->extra1);
> +	struct ctl_table fake = {};
> +
> +	if (write)
> +		return -EINVAL;
> +
> +	fake.data = stats;
> +	fake.maxlen = 3*sizeof(unsigned long);
> +
> +	ret = smp_call_function_single(cpu, getstats, &stats, 1);
> +	if (ret)
> +		return ret;

Haven't read the whole thing, but do any of these stats really
need to execute on the target CPU? They seem to be just readable
fields.

Or does it simply not matter because this proc call is too infrequent?

Anyways global broadcasts are discouraged, there is typically
always someone who feels their RT latency be messed up by them.

-Andi


-- 
ak@linux.intel.com -- Speaking for myself only.
