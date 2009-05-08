From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH 1/5] mm: Add __GFP_NO_OOM_KILL flag
Date: Fri, 8 May 2009 10:16:51 +0900
Message-ID: <20090508101651.aa4d513d.kamezawa.hiroyu__48660.4521204301$1241745734$gmane$org@jp.fujitsu.com>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera>
	<20090507154502.a7f51dd9.akpm@linux-foundation.org>
	<alpine.DEB.2.00.0905071554490.10759@chino.kir.corp.google.com>
	<200905080111.31273.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905080111.31273.rjw@sisk.pl>
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
Cc: kernel-testers@vger.kernel.org, jens.axboe@oracle.com, linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, fengguang.wu@intel.com, torvalds@linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 8 May 2009 01:11:30 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> +	for_each_populated_zone(zone)
> +		zone_set_flag(zone, ZONE_OOM_LOCKED);

> +	for_each_populated_zone(zone)
> +		zone_clear_flag(zone, ZONE_OOM_LOCKED);
> +

Isn't it better to make above 2 be functions and move to mm/oom_kill.c ?

Thanks,
-Kame
