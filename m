From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Tue, 25 May 2010 23:15:09 +0200
Message-ID: <201005252315.09981.rjw__14421.8344511048$1274822144$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1005251359580.1634-100000@iolanthe.rowland.org>
	<201005252221.55888.rjw@sisk.pl>
	<20100525204405.GE4455@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100525204405.GE4455@core.coreip.homeip.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Len Brown <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-doc@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Tejun Heo <tj@kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 25 May 2010, Dmitry Torokhov wrote:
> On Tue, May 25, 2010 at 10:21:55PM +0200, Rafael J. Wysocki wrote:
> > On Tuesday 25 May 2010, Dmitry Torokhov wrote:
...
> > Now, we can reject their patches, but that's not going to cause any progress
> > to happen, realistically.  Quite on the contrary, Android will continue to use
> > wakelocks and Android driver writers will continue to ignore the mainline
> > and the gap between the two kernel lines will only get wider and wider over
> > time.
> > 
> > And what really is the drawback if we merge the patches?  Quite frankly,
> > I don't see any.
> 
> Adding stuff that is not beneficial to anyone but a particular platform?
> It is uncommon to say the least.

Well, not quite.  We have a number of platform-specific drivers for one
example.

Also, In fact I think it would benefit everyone if Android users could run
mainline kernels without major modifications on their systems.

Also, I think it would benefit everyone if Android drivers were merged into
the mainline.

Moreover, I think this stuff may actually be useful to someone beyond Android,
because it's proven working and people can readily play with it.  Which is not
going to happen if it's not in the mainline.

And I don't believe a user space power manager is going to be implemented
in a platform-idependent way, if at all (assuming we reject the Android
patches).

Rafael
