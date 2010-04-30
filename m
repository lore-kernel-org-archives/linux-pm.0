From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Fri, 30 Apr 2010 06:24:43 +0200
Message-ID: <4BDA5B8B.50004@kernel.org>
References: <1272429119-12103-1-git-send-email-arve@android.com>
	<201004282250.44200.rjw@sisk.pl>
	<l2yd6200be21004282037rc063266by91db7f732ceaa529@mail.gmail.com>
	<201004292316.14524.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201004292316.14524.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hello,

On 04/29/2010 11:16 PM, Rafael J. Wysocki wrote:
>>> Also, we already have one PM workqueue.  It is used for runtime PM, but I guess
>>> it may be used just as well for the opportunistic suspend.  It is freezable,
>>> but would it hurt?
>>
>> No, it works, the freezable flag is just ignored when I call
>> pm_suspend and I don't run anything else on the workqueue while
>> threads are frozen. It does need to be a single threaded workqueue
>> though, so make sure you don't just change that.
> 
> Freezable workqueues have to be singlethread or else there will be unfixable
> races, so you can safely assume things will stay as they are in this respect.

Rafael, can you elaborate a bit more on this?  Just in case I missed
something while doing cmwq as it currently doesn't have such limit.

Thanks.

-- 
tejun
