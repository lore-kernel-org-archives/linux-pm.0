From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Run-time PM idea (was: Re: [RFC][PATCH 0/2] PM:
	Rearrange core suspend code)
Date: Tue, 9 Jun 2009 09:31:37 +0200
Message-ID: <200906090931.37626.oliver__18054.2936352596$1244532700$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0906081626120.13888-100000@netrider.rowland.org>
	<200906082331.58933.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906082331.58933.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Am Montag, 8. Juni 2009 23:31:58 schrieb Rafael J. Wysocki:
> If ->autosuspend() fails, the device power state may be known, but the co=
re
> can't be sure if the device is active. =A0This information is available to
> the driver and/or the bus type, which should change the status to whatever
> is appropriate.

That is quite confusing. You'd better define error returns.
One that would mean that the suspension has failed but the device is
unaffected, and another one that means that the device is in an
undefined state now.

> > The scheme doesn't include any mechanism for communicating runtime
> > power information up the device tree. =A0When a device is autosuspended,
> > its parent's driver should be told so that the driver can consider
> > autosuspending the parent.
>
> I thought the bus type's ->autosuspend() callback could take care of this.

That can't work because you have to operate between busses.

> > Likewise, if we want to autoresume a device below an autosuspended
> > parent, the parent should be autoresumed first. =A0Did you want to make=
 the
> > bus subsystem responsible for all of this?
>
> Yes, that was the idea.

That is an important point. Can some subsytems operate with a parent still
suspended?

	Regards
		Oliver
