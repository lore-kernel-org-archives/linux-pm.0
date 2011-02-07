From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Hide CONFIG_PM from users
Date: Mon, 7 Feb 2011 23:00:03 +0100
Message-ID: <201102072300.03986.rjw__44477.3864037872$1297116153$gmane$org@sisk.pl>
References: <1297081335-13631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<201102072215.59921.rjw@sisk.pl>
	<20110207214732.GA24703@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110207214732.GA24703@core.coreip.homeip.net>
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
Cc: Len Brown <len.brown@intel.com>, linux-embedded@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, February 07, 2011, Dmitry Torokhov wrote:
> On Mon, Feb 07, 2011 at 10:15:59PM +0100, Rafael J. Wysocki wrote:
> > On Monday, February 07, 2011, Mark Brown wrote:
> > > 
> > > Yeah, but some people seem very keen on removing the pointers to the PM
> > > ops entirely when CONFIG_PM is disabled which means that you end up with
> > > varying idioms for what you do with the PM ops as stuff gets ifdefed
> > > out.  Then again I'm not sure anything would make those people any
> > > happier.
> > 
> > I really think we should do things that makes sense rather that worry about
> > who's going to like or dislike it (except for Linus maybe, but he tends to like
> > things that make sense anyway).  At this point I think the change I suggested
> > makes sense, because it (a) simplifies things and (b) follows the quite common
> > practice which is to make PM callbacks depend on CONFIG_PM.
> 
> Many people make these callback dependent on PM not because it makes
> much sense but because it is possible to do so. However, aside of
> randconfig compile testing, nobody really tests drivers that implement
> PM in the !CONFIG_PM setting.

That I can agree with, but I'm not sure whether it is an argument against
the patch I've just posted or for it?

Rafael
