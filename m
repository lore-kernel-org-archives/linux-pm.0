From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Sun, 2 May 2010 22:10:53 +0200
Message-ID: <201005022210.54018.rjw__2170.66551927037$1272833201$gmane$org@sisk.pl>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<1272667021-21312-2-git-send-email-arve@android.com>
	<20100502065635.GA1790@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100502065635.GA1790@ucw.cz>
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
Cc: Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 02 May 2010, Pavel Machek wrote:
> Hi!
> 
> > Adds /sys/power/policy that selects the behaviour of /sys/power/state.
> > After setting the policy to opportunistic, writes to /sys/power/state
> > become non-blocking requests that specify which suspend state to enter
> > when no suspend blockers are active. A special state, "on", stops the
> > process by activating the "main" suspend blocker.
> 
> As I explained before (and got no reply),  the proposed interface is
> ugly. It uses one sysfs file to change semantics of another one.

In fact this behavior was discussed at the LF Collab Summit and no one
involved had any problem with that.

> > Signed-off-by: Arve Hj??nnev??g <arve@android.com>
> 
> NAK.

Ignored.

Thanks,
Rafael
