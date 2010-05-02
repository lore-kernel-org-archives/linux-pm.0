From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Sun, 2 May 2010 22:52:38 +0200
Message-ID: <20100502205238.GC9051__25098.1878176846$1272833625$gmane$org@elf.ucw.cz>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<1272667021-21312-2-git-send-email-arve@android.com>
	<20100502065635.GA1790@ucw.cz> <201005022210.54018.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201005022210.54018.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun 2010-05-02 22:10:53, Rafael J. Wysocki wrote:
> On Sunday 02 May 2010, Pavel Machek wrote:
> > Hi!
> > 
> > > Adds /sys/power/policy that selects the behaviour of /sys/power/state.
> > > After setting the policy to opportunistic, writes to /sys/power/state
> > > become non-blocking requests that specify which suspend state to enter
> > > when no suspend blockers are active. A special state, "on", stops the
> > > process by activating the "main" suspend blocker.
> > 
> > As I explained before (and got no reply),  the proposed interface is
> > ugly. It uses one sysfs file to change semantics of another one.
> 
> In fact this behavior was discussed at the LF Collab Summit and no one
> involved had any problem with that.

Well, I explained why I disliked in previous mail in more details, and
neither you nor Arve explained why it is good solution.

I was not on LF Collab summit, so unfortunately I can't comment on that.

> > > Signed-off-by: Arve Hj??nnev??g <arve@android.com>
> > 
> > NAK.
> 
> Ignored.

WTF?
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
