From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 16:51:09 +0200
Message-ID: <200707031651.10225.rjw@sisk.pl>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707031456.40890.rjw@sisk.pl>
	<1183472474.3722.13.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1183472474.3722.13.camel@johannes.berg>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 3 July 2007 16:21, Johannes Berg wrote:
> On Tue, 2007-07-03 at 14:56 +0200, Rafael J. Wysocki wrote:
> 
> > Still, can you please read this post from Alan Stern:
> > 
> > https://lists.linux-foundation.org/pipermail/linux-pm/2007-June/012847.html
> > 
> > ?  I don't think I'm able to repeat the arguments given in there in a
> > convincing way.
> 
> As I read it, Alan basically has two objections:
>  (1) drivers shouldn't need to worry about this
>  (2) suspend should be transparent to userspace
> 
> His proposed solution (freezing tasks when they cross the kernel
> boundary) helps for the s-t-r case, but in fact doesn't solve (1)
> because devices can be suspended at runtime

This is a different thing and a different infrastructure is needed for it (not
present at the moment).

> and then you certainly do not want to freeze tasks that try to access the
> device. 
> 
> (2) is related but not identical, what if you have a device suspended at
> runtime and some tasks tries to access it; should the task block until
> you wake up that device?

I think the device should be woken up in that case.

> I think the core of the discussion isn't appreciated by everybody here
> yet---we need to solve both run-time and suspend-to-ram-time device
> suspend, not just one of them.

For now, we're discussing the suspend-to-ram-time suspend only, for which
we have (some) infrastrcuture (and which should be supported by all drivers,
IMO).

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
