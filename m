From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 6/8] PM: Add suspend blocking work.
Date: Wed, 28 Apr 2010 22:22:58 +0200
Message-ID: <4BD89922.1040306@kernel.org>
References: <1272429119-12103-1-git-send-email-arve@android.com>
	<1272429119-12103-2-git-send-email-arve@android.com>
	<1272429119-12103-3-git-send-email-arve@android.com>
	<1272429119-12103-4-git-send-email-arve@android.com>
	<1272429119-12103-5-git-send-email-arve@android.com>
	<1272429119-12103-6-git-send-email-arve@android.com>
	<1272429119-12103-7-git-send-email-arve@android.com>
	<20100428194028.GA16389@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100428194028.GA16389@redhat.com>
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
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 04/28/2010 09:40 PM, Oleg Nesterov wrote:
>> +int schedule_suspend_blocking_work(struct suspend_blocking_work *work)
>> +{
>> ...
>> +	ret = schedule_work(&work->work);
> 
> Off-topic. We should probably export keventd_wq to avoid the duplications
> like this.

Yeah, had about the same thought.  cmwq exports it so I didn't suggest
it at this point but then again we don't really know whether or when
that series is going in so it might be a good idea to make that change
now.  Hmm...

Thanks.

-- 
tejun
