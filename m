From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFT] PCI changes related to wakeup (was: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again)
Date: Tue, 29 May 2012 19:29:40 +0200
Message-ID: <201205291929.41060.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1205291010190.1289-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1205291010190.1289-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Oleksij Rempel (fishor)" <bug-track@fisher-privat.net>, =?utf-8?q?D=C3=A2niel_Fraga?= <fragabr@gmail.com>, Andrey Rahmatullin <wrar@wrar.name>, Steven Rostedt <rostedt@goodmis.org>, linux-pm@lists.linux-foundation.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, May 29, 2012, Alan Stern wrote:
> On Sun, 27 May 2012, Rafael J. Wysocki wrote:
>=20
> > So, do you think we should apply [1/4] and [2/4] and try to work ar=
ound the
> > BIOS bug from https://bugzilla.kernel.org/show_bug.cgi?id=3D43278 (=
I suppose
> > we can do that by double checking if the target state returned by A=
CPI is
> > in agreement with the capabilities returned by the PCI layer)?
>=20
> Here's one possible approach.  It only solves part of the problem, bu=
t
> it ought to help with Bugzilla 43278 (D=C3=A2niel's case).  I suggest=
 that
> we don't believe the output from _SxW if the PCI PM capability
> indicates that PME is supported in a higher-numbered D state than _Sx=
W
> says.
>=20
> On D=C3=A2niel's smachine, _SxW returns D2

No, it doesn't.  In fact, _SxW is not present for that device in his DS=
DT.

> but the controller supports PME in D3; therefore we would use D3.

Yes, we can do that.  This goes along the lines of what I said in the b=
ug
entry.

> This still leaves the original problem.  It seems clear that ACPI
> won't be sufficient to solve this -- at least, it won't help in the
> case where the controller isn't enabled for wakeup.
>=20
> Therefore we really do need a quirk, probably in ehci-hcd like the=20
> original patch.  If it is restricted to apply only in cases where the=
=20
> DMI information lists ASUSTeK as the manufacturer, perhaps that will =
be=20
> sufficient.  (For some reason, the manufacturer field in D=C3=A2niel'=
s BIOS=20
> isn't initialized.)

Yeah.

I'll have a deeper look at this later today, I think.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
