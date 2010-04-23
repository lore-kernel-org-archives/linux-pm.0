From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/9] PM: Add suspend block api.
Date: Fri, 23 Apr 2010 12:45:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1004231244090.1777-100000__43801.1441649452$1272041204$gmane$org@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1004231204450.1777-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1004231204450.1777-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>
Cc: Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 23 Apr 2010, Alan Stern wrote:

> On Thu, 22 Apr 2010, [UTF-8] Arve Hj=C3=B8nnev=C3=A5g wrote:

> > +struct suspend_blocker {
> > +#ifdef CONFIG_SUSPEND_BLOCKERS
> > +	atomic_t            flags;
> > +	const char         *name;
> > +#endif
> =

> Why is flags an atomic_t?  Are you worried that drivers might try to =

> activate a suspend_blocker at the same time that it is being destroyed?
> If this happens, does the code do the right thing?  I don't think it =

> does -- if a race occurs, suspend_block() will leave flags set to the =

> wrong value.  The same goes for suspend_unblock().
> =

> Since these routines don't nest, there is also the possibility of a
> race between suspend_block() and suspend_unblock().  If the race goes
> one way the blocker is active; the other way it isn't.  Given that such
> problems already exist, why worry about what happens when the suspend
> blocker is destroyed?

Having now read the later patches, I see that you switch over to using =

a spinlock instead of an atomic_t.  My suggestion is to use a spinlock =

right from the start.  It will be less confusing.

Alan Stern
