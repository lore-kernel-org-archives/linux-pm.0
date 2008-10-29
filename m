From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Freezer: Don't count threads waiting for frozen
	filesystems.
Date: Wed, 29 Oct 2008 09:10:16 +0100
Message-ID: <E1Kv688-0007Kp-SN__2114.86082193932$1225268082$gmane$org@pomaz-ex.szeredi.hu>
References: <1224886068.6478.21.camel@nigel-laptop>
	<200810282321.59041.rjw@sisk.pl>
	<E1Kuxsg-0006PR-Tr@pomaz-ex.szeredi.hu>
	<200810290059.38411.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200810290059.38411.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl
Cc: linux-kernel@vger.kernel.org, ncunningham@crca.org.au, linux-pm@lists.linux-foundation.org, miklos@szeredi.hu
List-Id: linux-pm@vger.kernel.org

On Wed, 29 Oct 2008, Rafael J. Wysocki wrote:
> On Wednesday, 29 of October 2008, Miklos Szeredi wrote:
> > On Tue, 28 Oct 2008, Rafael J. Wysocki wrote:
> > > On Tuesday, 28 of October 2008, Miklos Szeredi wrote:
> > > > I would prefer a freezer-less solution.  Suspend to ram doesn't need
> > > > the freezer,
> > > 
> > > Well, yes it does.  And it will in forseeable future, AFAICS.
> > 
> > Umm, OK.  Last I remember everybody agreed that there's absolutely no
> > reason why processes need to be frozen, and the only important thing
> > is that drivers are not twiddling the hardware during suspend, and
> > this can usually easily be solved on the subsystem level.
> 
> Well, this turned out not to be the case in the meantime.
> 
> In fact to handle that without the freezer we'd have to synchronize
> every driver's suspend/resume callbacks with every possible way in
> which applications can access the device for regular I/O (for
> example for PCI devices this means any I/O other than configuration
> space accesses).

Not all callbacks.  I don't know what the current model is but AFAIR
it should be something like this:

  1) call drivers to prepare for suspend (allocate space, etc)
  2) stop all driver activity (plug queues, disable interrupts, etc)
  3) call drivers to actually save state and power down
  4) suspend

The part we are concerned is stopping driver activity.  It could be
done with a mutex, or it could be done by freezing tasks.  Adding a
mutex or other mechanism is the one I most like, but it's probably the
biggest work, so lets look at how to fix the freezing:

Currently the criteria for freezing is that userspace task has to exit
kernelspace, and kernel task has to hit a specific "freeze point".
This causes problems where we want to freeze tasks which are "stuck"
inside filesystems or other non-driver parts of the kernel.  We can
fix this two ways:

  a) mark additional places to freeze for userspace tasks as
  well. This is the direction Nigel seems to be taking.

  b) or instead we could allow freezing anywhere in uninterruptible
  sleep, _except_ where explicity marked.

Which is easier?  I don't know.  But I very storgly feel that marking
un-freezable places instead of marking freezable places is a much
cleaner solution.  It only affects parts of the kernel which have
something to do with suspend, instead of affecting parts of the kernel
which have absolutely nothing to do with suspend.

Miklos
