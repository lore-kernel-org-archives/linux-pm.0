From: Nigel Cunningham <nigel@tuxonice.net>
Subject: Re: [RFC][PATCH 1/5] PM/Freezer: Disable OOM killer when
 tasks are frozen
Date: Thu, 07 May 2009 09:00:43 +1000
Message-ID: <1241650843.19600.124.camel__10073.7585606568$1241650988$gmane$org@nigel-laptop>
References: <200905070040.08561.rjw@sisk.pl> <200905070041.04787.rjw@sisk.pl>
Reply-To: nigel@tuxonice.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905070041.04787.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi.

On Thu, 2009-05-07 at 00:41 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The OOM killer is not really going to work while tasks are frozen, so
> we can just give up calling it in that case.
> 
> This will allow us to safely use memory allocations for decreasing
> the number of saveable pages in the hibernation core code instead of
> using any artificial memory shriking mechanisms for this purpose.

Should we disable the warning that the nopage path gives if tasks are
frozen? I'm in two minds - if you get problems as a result, it might
help to diagnose them. On the other hand, you don't want tons of
warnings due to the hibernation code trying to allocate memory it can't
get. In TuxOnIce, I currently do all allocations with __GFP_NOWARN.

Regards,

Nigel
