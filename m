From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 9/19] TuxOnIce: Netlink support.
Date: Thu, 7 May 2009 06:34:29 +0200
Message-ID: <20090507043429.GA32391__17171.9564743855$1241670961$gmane$org@uranus.ravnborg.org>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<1241620755-22133-10-git-send-email-nigel@tuxonice.net>
	<20090506210330.GA29496@uranus.ravnborg.org>
	<1241645738.19600.97.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1241645738.19600.97.camel@nigel-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <nigel@tuxonice.net>
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, May 07, 2009 at 07:35:38AM +1000, Nigel Cunningham wrote:
> Hi Sam.
> 
> On Wed, 2009-05-06 at 23:03 +0200, Sam Ravnborg wrote:
> > On Thu, May 07, 2009 at 12:39:05AM +1000, Nigel Cunningham wrote:
> > > This patch adds support for communicating with a userspace helper via a
> > > netlink socket. It is used by the userspace user interface support and
> > > by the storage manager support.
> > > 
> > > Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>
> > > ---
> > >  kernel/power/Makefile           |    4 +
> > >  kernel/power/tuxonice_netlink.c |  339 +++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 343 insertions(+), 0 deletions(-)
> > >  create mode 100644 kernel/power/tuxonice_netlink.c
> > > 
> > > diff --git a/kernel/power/Makefile b/kernel/power/Makefile
> > > index 07efc8a..180b89a 100644
> > > --- a/kernel/power/Makefile
> > > +++ b/kernel/power/Makefile
> > > @@ -10,6 +10,10 @@ tuxonice_core-objs := tuxonice_modules.o tuxonice_sysfs.o tuxonice_highlevel.o \
> > >  
> > >  obj-$(CONFIG_TOI)		+= tuxonice_builtin.o
> > >  
> > > +ifdef CONFIG_NET
> > > +tuxonice_core-objs		+= tuxonice_netlink.o
> > > +endif
> > 
> > If you replace tuxonice_core-objs with tuxonice_core-y in your MAkefile the
> > above can be simplified to:
> > tuxonice_core-$(CONFIG_NET) += tuxonice_netlink.o
> > 
> > (On the assumption that CONFIG_NET is a bool)
> 
> Thanks for the review.
> 
> I have support for building tuxonice as modules that I'm not asking to
> be merged (at least not yet - it adds too many symbol exports at the
> moment). As a result, I did the simplification but left the
> tuxonice_core_objs definition. Is that what you'd do?

tuxonice_core-objs and tuxonice_core-y ahve equal semantics.
kbuild will recognize all .o files specified using tuxonice_core-y
as modules to be part of the tuxonice_core module.
So there is no need to define tuxonice_core-objs - that can
be replaced by tuxonice_core-y.

	Sam
