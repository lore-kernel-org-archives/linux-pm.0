From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend and
	hibernation callbacks (rev. 8)
Date: Mon, 14 Apr 2008 02:59:19 +0200
Message-ID: <200804140259.20962.rjw__28278.0105867007$1208134875$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0804131916420.3060-100000@netrider.rowland.org>
	<200804140207.19340.rjw@sisk.pl> <1208133631.6958.85.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1208133631.6958.85.camel@pasglop>
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
To: benh@kernel.crashing.org
Cc: Nigel Cunningham <ncunningham@crca.org.au>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 14 of April 2008, Benjamin Herrenschmidt wrote:
> 
> > Please have a look at this thread:
> > http://lkml.org/lkml/2008/3/21/322
> > (in short, the reporter sees APM suspend breakage under stress, occuring
> > because APM uses our suspending of devices without the freezer).
> > 
> > It mostly appears to work without the freezer, but that's bacuse no one
> > actually does things that might break it.  I don't think we can rely on users
> > being so kind to us forever. :-)
> 
> As far as I'm concerned, it's yet another case of the freezer papering
> over a problem rather than fixing it properly.

Well, this is not a user's point of view.

> If we're going to introduce new callbacks, we should have the right
> semantic from day 1 -and- fix those problems, rather than going to the
> same old recursive nonsensical arguments and do things to paper over
> problems.

Still, we're not supposed to break things, as far as the functionality is
concerned, and that's important, because it means we _have_ _to_ make changes
in steps.

To be more precise, what you suggest (move ->prepare() before the freezer
right now) means a patch with _functional_ changes (it's impossible to register
new children of dev after ->prepare(dev) has run which can affect the user
space in the window before ->prepare() and the freezer), whereas what I'd like
to do is the (present) patch without functional changes.

Thanks,
Rafael
