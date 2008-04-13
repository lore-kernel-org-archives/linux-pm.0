From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend
	and	hibernation callbacks (rev. 8)
Date: Mon, 14 Apr 2008 09:46:30 +1000
Message-ID: <1208130390.6958.71.camel__9158.55659773133$1208130543$gmane$org@pasglop>
References: <200804040111.15255.rjw@sisk.pl>
	<200804140027.12161.rjw@sisk.pl> <1208126822.6958.63.camel@pasglop>
	<200804140108.05447.rjw@sisk.pl>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200804140108.05447.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <ncunningham@crca.org.au>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


On Mon, 2008-04-14 at 01:08 +0200, Rafael J. Wysocki wrote:
> 
> Well, if we put ->prepare() before the freezer, what can it actually do?
> Certainly nothing that will block any (user space) task, because the freezer
> won't work after that.  So, all of the significant suspend work, like blocking
> tasks using the device etc., will have to be done by ->suspend().  Will that be
> convenient?  I'm not sure.  I'm not even sure that would be _doable_ at all.

Most of the actual suspending of requests queues etc... has to be done
in suspend. Nothing changed here. I don't see why it would change.
prepare() is a way to preallocate things when needed, cache things when
needed, etc... and possibly interact user space. At least that how I see
it.

It -is- acceptable to stop servicing user space after prepare() in some
well defined cases such as the DRM, as long as in-kernel users aren't
affected. But that's not necessarily what I have in mind. In the case us
userspace for example, the idea here is to perform the migration of all
the dirty data in the VRAM (that will be lost during suspend) out to
main memory (or AGP memory). That doesn't mean necessarily that the DRM
will stop servicing anything from there, it can still perform things. It
might mean that user space would have to disable some accelerations that
rely on dirty data in VRAM though until complete() is called.

> The point of view depends on what you think ->prepare() should be used for
> and I'm sure you have some specific cases in mind.  However, are they generic
> enough?

request_firmware() & caching the resulting firmware so that the driver
can resume & start operating right away is an example (think about NFS
over wireless here for example, or iSCSI). the DRM example above. In
general, any driver that needs to interact with user space, perform
large allocations, muck around with the VM, etc...

prepare() isn't intended to stop operations, but to
preload/cache/prepare and have userspace available for drivers where
this is needed. In some case, that might need the driver will continue
operating in some degraded mode (for example, a multiqueue driver can
degrade to a single queue with one pre-allocated request to avoid
relying on allocations).

I would expect most simple drivers not to need it of course.

Cheers,
Ben.
