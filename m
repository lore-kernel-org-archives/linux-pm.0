From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: wakeup code translated to .c
Date: Sun, 3 Feb 2008 23:33:02 +0100
Message-ID: <200802032333.02821.rjw@sisk.pl>
References: <20080130120111.GB22820@elf.ucw.cz> <200802031857.02422.rjw@sisk.pl> <20080203181648.GA1629@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754571AbYBCWfb@vger.kernel.org>
In-Reply-To: <20080203181648.GA1629@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org

On Sunday, 3 of February 2008, Pavel Machek wrote:
> Hi!
>=20
> > > This version works on 32-bit, and builds on 64-bit (but I'm prett=
y
> > > sure it does not work. 32-bit code probably needs to go into rm/.=
=2E..)
> > >=20
> >=20
> > Do you have an updated version or is this the latest one?
>=20
> I'm glad you ask ;-). Here's reasonably-recent version (I have
> slightly cleaner one, but it got obscured by 2.6.24-git merge), I
> eventually got it to work on 64-bit, by reusing trampoline.S code.

I needed to rebase it against the current mainline (Makefile conflict).

Some remarks:

- It looks like arch/x86/kernel/acpi/wakeup.S is not necessary any more=
=2E

- These warnings:

/home/rafael/src/linux-2.6/arch/x86/kernel/acpi/sleep.c: In function =E2=
=80=98acpi_save_state_mem=E2=80=99:
/home/rafael/src/linux-2.6/arch/x86/kernel/acpi/sleep.c:41: warning: in=
itialization makes pointer from integer without a cast
/home/rafael/src/linux-2.6/arch/x86/kernel/acpi/sleep.c:50: warning: fo=
rmat =E2=80=98%d=E2=80=99 expects type =E2=80=98int=E2=80=99, but argum=
ent 2 has type =E2=80=98long unsigned int=E2=80=99
/home/rafael/src/linux-2.6/arch/x86/kernel/acpi/sleep.c:50: warning: fo=
rmat =E2=80=98%d=E2=80=99 expects type =E2=80=98int=E2=80=99, but argum=
ent 3 has type =E2=80=98long unsigned int=E2=80=99
/home/rafael/src/linux-2.6/arch/x86/kernel/acpi/sleep.c:70: warning: IS=
O C90 forbids mixed declarations and code
/home/rafael/src/linux-2.6/arch/x86/kernel/acpi/sleep.c:82: warning: as=
signment makes integer from pointer without a cast
/home/rafael/src/linux-2.6/arch/x86/kernel/acpi/sleep.c:83: warning: as=
signment makes integer from pointer without a cast
/home/rafael/src/linux-2.6/arch/x86/kernel/acpi/sleep.c:84: warning: IS=
O C90 forbids mixed declarations and code
/home/rafael/src/linux-2.6/arch/x86/kernel/acpi/sleep.c:87: warning: IS=
O C90 forbids mixed declarations and code
/home/rafael/src/linux-2.6/arch/x86/kernel/acpi/sleep.c:90: warning: as=
signment makes integer from pointer without a cast
/home/rafael/src/linux-2.6/arch/x86/kernel/acpi/sleep.c:91: warning: IS=
O C90 forbids mixed declarations and code

look pretty scary.

- Could the real mode directory be called just "real-mode" or something=
 like
  this ("rm" is not very meaningful :-))?

Apart from the above and the _WAKEUP hacks mentioned elsewhere, it look=
s okay
(from a very high orbit).

Greetings,
Rafael
