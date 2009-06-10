From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [patch update] Re: Run-time PM idea (was: Re:
	[RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Wed, 10 Jun 2009 23:38:34 +0200
Message-ID: <200906102338.35183.oliver__22426.6288722449$1244669923$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0906082233490.19072-100000@netrider.rowland.org>
	<200906101620.26559.oliver@neukum.org>
	<200906102127.57136.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906102127.57136.rjw@sisk.pl>
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

Am Mittwoch, 10. Juni 2009 21:27:56 schrieb Rafael J. Wysocki:
> > What happens if the parent's parent is also suspended? It seems to me
> > that you must code this recursively.
>
> Hmm, I thought I did.
>
> [Looks]
>
> pm_request_resume(dev) will call pm_request_resume(dev->parent), if
> necessary, and that will call pm_request_resume(dev->parent->parent) and =
so
> on. =A0Each of them will queue a work item and the one for the topmost pa=
rent
> will be queued first. =A0So, the resume requests for all parents will be
> executed before the one for the device, due to the fact that the workqueue
> is singlethread.

Sneaky, I overlooked that.

> Well, there is a bug related to it, namely pm_autosuspend() may change the
> status to RPM_SUSPENDED after pm_request_resume() has changed it to
> RPM_WAKE, that needs fixing.

Ok, maybe this is related. You recurse if the parent isn't in RPM_ACTIVE.
But that is not enough. You must ensure that all the nodes higher up stay
in RPM_ACTIVE. It seems to me that you must go up until you find an
active node (or the root) and put it a blocked state.

	Regards
		Oliver
