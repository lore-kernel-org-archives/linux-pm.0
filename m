From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Fri, 30 Apr 2010 19:26:18 +0200
Message-ID: <20100430172618.GA9043__38064.4431840212$1272648677$gmane$org@redhat.com>
References: <1272429119-12103-1-git-send-email-arve@android.com>
	<201004282250.44200.rjw@sisk.pl>
	<l2yd6200be21004282037rc063266by91db7f732ceaa529@mail.gmail.com>
	<201004292316.14524.rjw@sisk.pl> <4BDA5B8B.50004@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4BDA5B8B.50004@kernel.org>
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
Cc: Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 04/30, Tejun Heo wrote:
>
> On 04/29/2010 11:16 PM, Rafael J. Wysocki wrote:
> >>> Also, we already have one PM workqueue.  It is used for runtime PM, but I guess
> >>> it may be used just as well for the opportunistic suspend.  It is freezable,
> >>> but would it hurt?
> >>
> > Freezable workqueues have to be singlethread or else there will be unfixable
> > races, so you can safely assume things will stay as they are in this respect.
>
> Rafael, can you elaborate a bit more on this?  Just in case I missed
> something while doing cmwq as it currently doesn't have such limit.

Currently _cpu_down() can't flush and/or stop the frozen cwq->thread.

IIRC this is fixable, but needs the nasty complications. We should
thaw + stop the frozen cwq->thread, then move the pending works to
another CPU.

Oleg.
