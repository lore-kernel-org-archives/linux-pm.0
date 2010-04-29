From: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 0/2] workqueue fixlets (Was: PM: Add suspend
	blocking work.)
Date: Thu, 29 Apr 2010 21:44:47 +0200
Message-ID: <20100429194447.GA17280@redhat.com>
References: <1272429119-12103-1-git-send-email-arve@android.com>
	<20100428194028.GA16389@redhat.com>
	<4BD89922.1040306@kernel.org> <201004282308.10751.rjw@sisk.pl>
	<20100429185851.GA13862@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Tejun Heo <tj@kernel.org>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 04/29, Oleg Nesterov wrote:
>
> I don't really care, this change is trivial. But to me it makes more
> sense to push the trivial/simple changes ahead. Unless they really
> complicate the maintainging of the pending cmwq changes.
>
> Hmm... Speaking about keventd_wq, I just noticed flush_delayed_work()
> needs the fix:

So. I'd suggestd these 2 simple patches for now.

Please note that 2/2 is really trivial, it only adds EXPORT_SYMBOL but
avoids the possible cleanups to minimize the conflicts with the pending
cmwq changes. However, please feel free to ignore this patch.

As for 1/2, imho it is always better to fix the bug asap, even if it is
minor.

Oleg.
