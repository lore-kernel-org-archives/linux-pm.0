From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: better oopsing when frozen
Date: Wed, 27 Jul 2011 11:21:21 +0200
Message-ID: <201107271121.21348.rjw__4463.36769168756$1311758484$gmane$org@sisk.pl>
References: <201107251043.19932.oneukum@suse.de>
	<201107270024.11194.rjw@sisk.pl>
	<20110726154502.14c7b51b.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110726154502.14c7b51b.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Oliver Neukum <oneukum@suse.de>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, July 27, 2011, Andrew Morton wrote:
> On Wed, 27 Jul 2011 00:24:11 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > > Hi Rafael,
> > > 
> > > I had a problem with the kernel stopping the machine forever because I got an
> > > oops while tasks were frozen. It seems to me that we should thaw when this
> > > happens. How about this approach?
> > 
> > Well, we do something like this already for the OOM killer (see
> > oom_killer_disable() and friends), so I think it would be better to
> > simply extend/modify that mechanism instead of adding a new one
> > doing almost exactly the same thing.
> > 
> > I have no complaints about adding thaw_in_oops(), though, so long as
> > Andrew thinks it makes sense.
> 
> mm...  The patch as proposed is very simple, direct, explicit.  I
> suspect that trying to embed this operation within some other one would
> end up producing a less clear result.  Sometimes we do exceptional and
> weird things, and leaving the code exceptional and weird-looking is
> better than hiding it in some framework, if you follow what I mean.

My point is that instead of using the oom_killer_disabled variable in
page_alloc.c, we could use a oom_killer_disabled() function returning
the value of the new tasks_are_frozen variable.  Then,
oom_killer_disable/enable() won't be necessary any more.

> It does need some code comments to explain to people what it's doing
> and more importantly why it's doing it.  Also, something which doesn't
> break the build when CONFIG_FREEZER=n would be nice.

Right.

Thanks,
Rafael
