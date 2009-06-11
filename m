From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [patch update] Re: Run-time PM idea (was: Re:
	[RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Thu, 11 Jun 2009 15:57:48 +0200
Message-ID: <200906111557.49490.oliver__13864.9981738583$1244728762$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0906101942280.29717-100000@netrider.rowland.org>
	<200906111548.33751.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906111548.33751.rjw@sisk.pl>
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

Am Donnerstag, 11. Juni 2009 15:48:33 schrieb Rafael J. Wysocki:
> > > But after pm_request_resume() returns there's no means to make sure
> > > nothing alters it back to RPM_SUSPENDED. The workqueue doesn't help
> > > you because you've scheduled nothing by that time. The suspension will
> > > work because C is still in RPM_SUSPENDED.
> >
> > This is an example where usage counters come in handy.
>
> Do you mean we can count suspend/resume requests for a device?

No, we count reasons a device cannot be suspended. Drivers are allowed to
add their own reasons. The core uses that mechanism to indicate that an
ongoing resumption lower down is also a reason.
The count going to zero is equivalent to a request to suspend.

	Regards
		Oliver
