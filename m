From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [patch update] Re: Run-time PM idea (was: Re:
	[RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Thu, 11 Jun 2009 01:15:30 +0200
Message-ID: <200906110115.30729.oliver__27233.3535286181$1244675734$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0906101656100.2589-100000@iolanthe.rowland.org>
	<200906102331.14267.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906102331.14267.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Am Mittwoch, 10. Juni 2009 23:31:13 schrieb Rafael J. Wysocki:
> > > +/**
> > > + * pm_check_children - Check if all children of a device have been
> > > suspended. + * @dev: Device to check.
> > > + *
> > > + * Returns 0 if all children of the device have been suspended or
> > > -EBUSY + * otherwise.
> > > + */
> >
> > We might want to do a runtime suspend even if the device's children
> > aren't already suspended. =A0For example, you could suspend a link while
> > leaving the device on the other end of the link at full power --
> > especially if powering down the device is slow but changing the link's
> > power level is fast.
>
> Well, this means that the dependencies between devices in the device tree
> are pretty much useless for the run-time PM as far as the core is
> concerned. =A0In which case, why did you mention them at all?

Some bussystems need this constraint others don't or only for some nodes.
We need a way to communicate this to the core.

	Regards
		Oliver
