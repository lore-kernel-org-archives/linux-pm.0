From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend and
	hibernation callbacks (rev. 8)
Date: Mon, 14 Apr 2008 14:25:22 +0200
Message-ID: <200804141425.24096.rjw__43869.4849647165$1208176118$gmane$org@sisk.pl>
References: <200804040111.15255.rjw@sisk.pl> <1208134017.6958.94.camel@pasglop>
	<1208137034.29577.41.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1208137034.29577.41.camel@nigel-laptop>
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
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 14 of April 2008, Nigel Cunningham wrote:
> Hi.
> 
> On Mon, 2008-04-14 at 10:46 +1000, Benjamin Herrenschmidt wrote:
> > On Mon, 2008-04-14 at 02:31 +0200, Rafael J. Wysocki wrote:
> > > 
> > > Well, in our discussions with Alan Stern ->prepare() turned out to be necessary
> > > for exactly one reason, preventing new children of the device from being
> > > registered (by threads concurrent wrt the suspend thread).  For this reason,
> > > it doesn't really seem a good idea to run it before the freezer (seemingly, it
> > > would be difficult to avoid situations in which the freezer would fail as a
> > > result of ->prepare()).
> > 
> > I'm opposed to designing something around the freezer since we know it
> > will ultimately go away.
> 
> I don't think we should be assuming that the freezer will ultimately go
> away. Aiming for that is one thing, assuming that we know what will
> happen in the future is another.

I agree.

> Frankly, I hope it doesn't go away, because right now it's the only way I
> can see that we can capture as close as possible to a complete image of
> memory for hibernation. I know that some people don't care about that option,
> but others of us find it extremely useful.

Well, I think there's another way, but that's for a separate discussion. :-)

> > If things like USB have issues with userland doing nasty things after
> > prepare(), then those things need to be fixed. The freezer will only
> > hide bugs and not even always or properly and not on all archs.
> 
> Having said the above, I also agree with this. I want to see things
> being done properly too. I believe the freezer still has a place when it
> comes to providing the environment in which we can capture a consistent
> image for hibernation, but that shouldn't get in the way of kernel
> drivers (or even well designed userspace drivers) doing their thing,
> including reloading firmware post-atomic restore or post-suspend-to-ram.

Unfortunately, if ->prepare() is to be run before the freezer, the writers of
the ->prepare() routines will have to make sure they won't block any freezable
tasks, so that the freezer doesn't fail.  This, in turn, will require them to
learn how the freezer works etc., which I'm not quite sure is really necessary.

> > > It looks like you'd like to have a third callback executed before the freezer,
> > > but OTOH I don't see the reason not to use a notifier for such things.
> > 
> > That's just gratuituous complication imho. We can add callbacks every
> > week and no driver will every find out what to use and when.
> > 
> > prepare() has quite well defined and nice semantics if you ignore your
> > freezer trickery. It matches well with the needs of things like
> > request_firmware or the DRM, and possibly a few others, in addition to
> > matching well the need to block bus discovery.
> > 
> > If some drivers have issue because of what userland might do after
> > prepare(), then those drivers need to be fixed. We all know the freezer
> > is not a proper solution. It just hides problems and not always
> > correctly.
> 
> Not a proper/complete solution to every problem.
> 
> > > I have imagined that while we have the freezer, the operations that need to
> > > be carried out with the user space available will be done using notifiers
> > > and the rest will be done by ->prepare() and ->suspend().  Next, when we
> > > finally drop the freezer, it will be possible to move the code from the
> > > notifiers into ->prepare() and drop the notifiers altogether.
> > 
> > Why do this two steps ? What is the point ?
> 
> 1 step for pre-freezing prepare (load firmware you might want to restore
> later, allocate memory) and 1 step for post-freezing prepare (stop
> driver discovery)? I'm not sure that this is what Rafael has in mind,
> though.

Yes, sort of.

I think that, as long as there is the freezer, we need two "preparation" steps
in general, one to be executed with the user space available and one to be
executed after it's been frozen.  The difference between them is quite clear
to me and trying to forcibly merge them into one routine will eventually lead
to problems.

If the freezer is not there, though, we can merge the two just fine.  This
seems to be a natural way to go to me and that's why I'm trying to use this
approach.

Thanks,
Rafael
