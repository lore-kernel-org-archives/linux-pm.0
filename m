From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFT] PCI changes related to wakeup (was: Re: [linux-pm] ehci_hcd
 related S3 lockup on ASUS laptops, again)
Date: Fri, 1 Jun 2012 10:55:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1206011054510.1610-100000@iolanthe.rowland.org>
References: <4fc7ea97.c383ec0a.2707.ffffa637@mx.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <4fc7ea97.c383ec0a.2707.ffffa637@mx.google.com>
Sender: linux-acpi-owner@vger.kernel.org
To: =?UTF-8?B?RMOibmllbA==?= Fraga <fragabr@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "Oleksij Rempel (fishor)" <bug-track@fisher-privat.net>, Andrey Rahmatullin <wrar@wrar.name>, Steven Rostedt <rostedt@goodmis.org>, linux-pm@lists.linux-foundation.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 31 May 2012, D=C3=A2niel Fraga wrote:

> On Thu, 31 May 2012 17:07:36 -0400 (EDT)
> Alan Stern <stern@rowland.harvard.edu> wrote:
>=20
> > Here's my attempt.  Everybody, please try this patch with the
> > 151b61284776 commit removed.  Make sure that CONFIG_USB_DEBUG is
> > enabled so we can check the controller's power state during suspend=
,=20
> > and check that the "broken D3 during system sleep on ASUS" message=20
> > shows up during booting.
>=20
> 	Hi Alan, I tested your patch. It wakes up fine through
> keyboard, but it didn't write the "broken D3 during..." message. I
> attached the dmesg output.

That's good.  The message isn't supposed to appear on your system=20
because your system works properly without any special treatment.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
