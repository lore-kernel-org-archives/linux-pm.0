From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Thu, 20 May 2010 11:11:11 +0200
Message-ID: <20100520111111.333beb73__10102.6946366348$1274367740$gmane$org@schatten.dmk.lab>
References: <1273810273-3039-1-git-send-email-arve@android.com>
	<1273810273-3039-2-git-send-email-arve@android.com>
	<20100518131111.GB1563@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100518131111.GB1563@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>, Kleen <ak@linux.intel.com>, Andi@smtp1.linux-foundation.org, linux-doc@vger.kernel.org, Tejun@smtp1.linux-foundation.org, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, Heo <tj@kernel.org>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 18 May 2010 15:11:11 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> On Thu 2010-05-13 21:11:06, Arve Hj??nnev??g wrote:
> > Adds /sys/power/policy that selects the behaviour of /sys/power/state.
> > After setting the policy to opportunistic, writes to /sys/power/state
> > become non-blocking requests that specify which suspend state to
> > enter
> 
> Yeah, one file selects behavior of another file, and to read available
> states for opportunistic, you have to write to file first.
> 
> I still don't like the interface.
> 

Actually, what would be a better interface? 

I wonder why it is not like this:

/sys/power/state 
	no change, works with and without opportunistic suspend the
	same. Ignores suspend blockers. Really no change. (From user
	perspective)

/sys/power/opportunistic
	On / Off
	While Off the opportunistic suspend is off.
	While On, the opportunistic suspend is on and if there are no
	suspend blockers the system goes to suspend. 

Cheers,
Flo
