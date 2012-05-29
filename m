From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFT] PCI changes related to wakeup (was: Re: [linux-pm] ehci_hcd
 related S3 lockup on ASUS laptops, again)
Date: Tue, 29 May 2012 10:23:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1205291010190.1289-100000@iolanthe.rowland.org>
References: <201205270059.04166.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <201205270059.04166.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Oleksij Rempel (fishor)" <bug-track@fisher-privat.net>, =?UTF-8?Q?D=C3=A2niel_Fraga?= <fragabr@gmail.com>, Andrey Rahmatullin <wrar@wrar.name>, Steven Rostedt <rostedt@goodmis.org>, linux-pm@lists.linux-foundation.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 27 May 2012, Rafael J. Wysocki wrote:

> So, do you think we should apply [1/4] and [2/4] and try to work arou=
nd the
> BIOS bug from https://bugzilla.kernel.org/show_bug.cgi?id=3D43278 (I =
suppose
> we can do that by double checking if the target state returned by ACP=
I is
> in agreement with the capabilities returned by the PCI layer)?

Here's one possible approach.  It only solves part of the problem, but
it ought to help with Bugzilla 43278 (D=C3=A2niel's case).  I suggest t=
hat
we don't believe the output from _SxW if the PCI PM capability
indicates that PME is supported in a higher-numbered D state than _SxW
says.

On D=C3=A2niel's smachine, _SxW returns D2 but the controller supports =
PME=20
in D3; therefore we would use D3.

This still leaves the original problem.  It seems clear that ACPI
won't be sufficient to solve this -- at least, it won't help in the
case where the controller isn't enabled for wakeup.

Therefore we really do need a quirk, probably in ehci-hcd like the=20
original patch.  If it is restricted to apply only in cases where the=20
DMI information lists ASUSTeK as the manufacturer, perhaps that will be=
=20
sufficient.  (For some reason, the manufacturer field in D=C3=A2niel's =
BIOS=20
isn't initialized.)

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
