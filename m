From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch update] Re: Run-time PM idea (was: Re:
 [RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Wed, 10 Jun 2009 19:42:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906101942280.29717-100000__10744.4840985865$1244677416$gmane$org@netrider.rowland.org>
References: <200906110107.23023.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906110107.23023.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 11 Jun 2009, Oliver Neukum wrote:

> Am Donnerstag, 11. Juni 2009 00:01:20 schrieb Rafael J. Wysocki:
> > We have queued up resume requests for the device's parent, its parent e=
tc.,
> > the topmost one goes first. =A0The workqueue is singlethread, so
> > pm_autoresume() is going to be run for all parents before the device
> > itself, so if that were the only resume mechanism, it would be enough to
> > check if the parent is RPM_ACTIVE.
> =

>             A (IDLE)
>     /                                \
> B (SUSPENDED)         C (SUSPENDED)
> =

> Suppose C is to be resumed. This means first in case of A the request
> to suspend would be cancelled. Here you drop the locks:
> =

> +           && (dev->parent->power.runtime_status =3D=3D RPM_IDLE
> +             || dev->parent->power.runtime_status =3D=3D RPM_SUSPENDING
> +             || dev->parent->power.runtime_status =3D=3D RPM_SUSPENDED))=
 {
> +               spin_unlock_irqrestore(&dev->power.lock, flags);
> +               spin_unlock_irqrestore(&dev->parent->power.lock, parent_f=
lags);
> +
> +               /* We have to resume the parent first. */
> +               pm_request_resume(dev->parent);
> =

> But after pm_request_resume() returns there's no means to make sure
> nothing alters it back to RPM_SUSPENDED. The workqueue doesn't help
> you because you've scheduled nothing by that time. The suspension will
> work because C is still in RPM_SUSPENDED.

This is an example where usage counters come in handy.

Alan Stern
