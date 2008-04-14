From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend and
	hibernation callbacks (rev. 8)
Date: Mon, 14 Apr 2008 02:31:30 +0200
Message-ID: <200804140231.32245.rjw__37530.3883375183$1208133173$gmane$org@sisk.pl>
References: <200804040111.15255.rjw@sisk.pl> <200804140108.05447.rjw@sisk.pl>
	<1208130390.6958.71.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1208130390.6958.71.camel@pasglop>
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
> On Mon, 2008-04-14 at 01:08 +0200, Rafael J. Wysocki wrote:
> > 
> > Well, if we put ->prepare() before the freezer, what can it actually do?
> > Certainly nothing that will block any (user space) task, because the freezer
> > won't work after that.  So, all of the significant suspend work, like blocking
> > tasks using the device etc., will have to be done by ->suspend().  Will that be
> > convenient?  I'm not sure.  I'm not even sure that would be _doable_ at all.
> 
> Most of the actual suspending of requests queues etc... has to be done
> in suspend. Nothing changed here. I don't see why it would change.
> prepare() is a way to preallocate things when needed, cache things when
> needed, etc... and possibly interact user space. At least that how I see
> it.
> 
> It -is- acceptable to stop servicing user space after prepare() in some
> well defined cases such as the DRM, as long as in-kernel users aren't
> affected. But that's not necessarily what I have in mind. In the case us
> userspace for example, the idea here is to perform the migration of all
> the dirty data in the VRAM (that will be lost during suspend) out to
> main memory (or AGP memory). That doesn't mean necessarily that the DRM
> will stop servicing anything from there, it can still perform things. It
> might mean that user space would have to disable some accelerations that
> rely on dirty data in VRAM though until complete() is called.
> 
> > The point of view depends on what you think ->prepare() should be used for
> > and I'm sure you have some specific cases in mind.  However, are they generic
> > enough?
> 
> request_firmware() & caching the resulting firmware so that the driver
> can resume & start operating right away is an example (think about NFS
> over wireless here for example, or iSCSI). the DRM example above. In
> general, any driver that needs to interact with user space, perform
> large allocations, muck around with the VM, etc...
> 
> prepare() isn't intended to stop operations, but to
> preload/cache/prepare and have userspace available for drivers where
> this is needed. In some case, that might need the driver will continue
> operating in some degraded mode (for example, a multiqueue driver can
> degrade to a single queue with one pre-allocated request to avoid
> relying on allocations).
> 
> I would expect most simple drivers not to need it of course.

Well, in our discussions with Alan Stern ->prepare() turned out to be necessary
for exactly one reason, preventing new children of the device from being
registered (by threads concurrent wrt the suspend thread).  For this reason,
it doesn't really seem a good idea to run it before the freezer (seemingly, it
would be difficult to avoid situations in which the freezer would fail as a
result of ->prepare()).

It looks like you'd like to have a third callback executed before the freezer,
but OTOH I don't see the reason not to use a notifier for such things.

I have imagined that while we have the freezer, the operations that need to
be carried out with the user space available will be done using notifiers
and the rest will be done by ->prepare() and ->suspend().  Next, when we
finally drop the freezer, it will be possible to move the code from the
notifiers into ->prepare() and drop the notifiers altogether.

Since, as you said, there aren't too many drivers that will need anything like
that, it seems perfectly doable to me.

Thanks,
Rafael


> 
> Cheers,
> Ben.
> 
> 
> 
> 
> 



-- 
"Premature optimization is the root of all evil." - Donald Knuth
