From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2] workqueues: export keventd_wq
Date: Fri, 30 Apr 2010 20:11:14 +0200
Message-ID: <4BDB1D42.10806@kernel.org>
References: <1272429119-12103-1-git-send-email-arve@android.com>
	<20100428194028.GA16389@redhat.com>
	<4BD89922.1040306@kernel.org> <201004282308.10751.rjw@sisk.pl>
	<20100429185851.GA13862@redhat.com>
	<20100429194447.GA17280@redhat.com>
	<20100429194545.GC17280@redhat.com> <4BDA67C1.7050709@kernel.org>
	<t2gd6200be21004292239r582b8a43l2409491b8d32ef1b@mail.gmail.com>
	<4BDA700C.3050509@kernel.org> <20100430180520.GB9043@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100430180520.GB9043@redhat.com>
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

Hello,

On 04/30/2010 08:05 PM, Oleg Nesterov wrote:
> Right, but this allows to make schedule_xxx/flush_scheduled_work
> inline and kill more EXPORT_SYMBOL's, and cmwq exports it anyway
> (iirc it also renames it).

Yeah, the 'iirc' part was why I didn't want to export it at this point. :-)

> OK. Let's forget this patch. We can unify schedule_suspend_blocking_work
> and queue_suspend_blocking_work later, or Arve can add this export into
> his patch (without EXPORT_SYMBOL) - either way I agree. This is very
> minor issue, I regret I originated this almost offtopic noise ;)

And, again, yeah, let's do it later.

Thanks.

-- 
tejun
