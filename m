From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Sun, 2 May 2010 23:29:48 +0200
Message-ID: <201005022329.48309.rjw__37691.370669245$1272835777$gmane$org@sisk.pl>
References: <1272667021-21312-1-git-send-email-arve@android.com>
	<201005022210.54018.rjw@sisk.pl> <20100502205238.GC9051@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100502205238.GC9051@elf.ucw.cz>
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
> On Sun 2010-05-02 22:10:53, Rafael J. Wysocki wrote:
> > On Sunday 02 May 2010, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > Adds /sys/power/policy that selects the behaviour of /sys/power/state.
> > > > After setting the policy to opportunistic, writes to /sys/power/state
> > > > become non-blocking requests that specify which suspend state to enter
> > > > when no suspend blockers are active. A special state, "on", stops the
> > > > process by activating the "main" suspend blocker.
> > > 
> > > As I explained before (and got no reply),  the proposed interface is
> > > ugly. It uses one sysfs file to change semantics of another one.
> > 
> > In fact this behavior was discussed at the LF Collab Summit and no one
> > involved had any problem with that.
> 
> Well, I explained why I disliked in previous mail in more details,

We do exactly the same thing with 'pm_test', so I'm not sure what the problem is.

> and neither you nor Arve explained why it is good solution.

Because it's less confusing.  Having two different attributes returning
almost the same contents and working in a slightly different way wouldn't be
too clean IMO.

Also it reduces code duplication slightly.

> I was not on LF Collab summit, so unfortunately I can't comment on that.
> 
> > > > Signed-off-by: Arve Hj??nnev??g <arve@android.com>
> > > 
> > > NAK.
> > 
> > Ignored.
> 
> WTF?

Literally.  I'm not going to take that NAK into consideration.

Rafael
