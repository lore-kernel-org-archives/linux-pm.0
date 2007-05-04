From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Why don't we use _TTS method?
Date: Fri, 4 May 2007 22:09:02 +0200
Message-ID: <200705042209.03655.rjw__17171.8753911138$1178309149$gmane$org@sisk.pl>
References: <B28E9812BAF6E2498B7EC5C427F293A4026B61BC@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <B28E9812BAF6E2498B7EC5C427F293A4026B61BC@orsmsx415.amr.corp.intel.com>
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
To: "Moore, Robert" <robert.moore@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Friday, 4 May 2007 20:10, Moore, Robert wrote:
> "New" is of course relative. In the ACPI world, anything about ACPI 3.0
> is still considered "new". Windows has yet to fully implement ACPI 2.0,
> let alone ACPI 3.0...
>=20
> Please point me to where the "spec spec seems to suggest that _GTS
> should be executed with interrupts off", as I don't think it should.

The ACPI 2.0 specification, 7.3.3, says:

"OSPM will set the sleep enable (SLP_EN) bit in the PM1 control register
immediately following the execution of the _GTS control method without
performing any other physical I/O or allowing any interrupt servicing."

This is also clearly stated in Subsection 9.1.

Yet, according to the same specification, 9.1.6:

"7. OSPM executes the _GTS control method, passing an argument that indic=
ates
    the sleeping state to be entered (1, 2, 3, or 4 representing S1, S2, =
S3, and
    S4).
8. OSPM clears the WAK_STS in the PM1a_STS and PM1b_STS registers.
9. OSPM saves the local processor=E2=80=99s context to memory.
10. OSPM flushes caches (only if entering S1, S2 or S3).
11. OSPM sets GPE enable registers to ensure that all appropriate wake si=
gnals are armed.
12. If entering an S4 state using the S4BIOS mechanism, OSPM writes the
    S4BIOS_REQ value (from the FADT) to the SMI_CMD port. This passes con=
trol
    to the BIOS, which then transitions the platform into the S4BIOS stat=
e.
13. If not entering an S4BIOS state, then OSPM writes SLP_TYPa (from the
    associated sleeping object) with the SLP_ENa bit set to the PM1a_CNT
    register.
14. OSPM writes SLP_TYPb with the SLP_EN bit set to the PM1b_CNT register=
."

which kind of contradicts the previous requirement.  Still, 8-14 look lik=
e
things that should be done with interrupts off.

> In any case, the AML interpreter cannot be executed with interrupts off.
> There is way too much going on in that code.

Well, perhaps we can execute _GTS immediately before switching interrupts=
 off.

Greetings,
Rafael


> > -----Original Message-----
> > From: Rafael J. Wysocki [mailto:rjw@sisk.pl]
> > Sent: Friday, May 04, 2007 1:51 AM
> > To: Alexey Starikovskiy
> > Cc: Moore, Robert; ACPI Devel Maling List; pm list; Pavel Machek
> > Subject: Re: Why don't we use _TTS method?
> >=20
> > Hi Alexey,
> >=20
> > On Friday, 4 May 2007 06:34, Alexey Starikovskiy wrote:
> > > Rafael,
> > >
> > > code in prepare() and enter() is split as code with interrupts on
> and
> > > code with interrupts off.
> >=20
> > I see.  Still, the spec seems to suggest that _GTS should be executed
> with
> > interrupts off, but we run it in the 'interrupts on' part of code.
> Isn't
> > that
> > wrong?
> >=20
> > > thus it doesn't quite follow a spec in regards of driver suspend.
> >=20
> > Yes.
> >=20
> > > Basically we need to either split it to smaller pieces or have hook=
s
> > > to control interrupts/driver suspend from this code.
> >=20
> > I'd like to split it and I'd like to figure out *how* to do this.
> More
> > precisely, I'd like to learn which part of acpi_pm_prepare() should b=
e
> > executed before device_suspend() and which part can be run after it.
> > Analogously, I'd like to learn which part of acpi_pm_finish() needs t=
o
> be
> > run before device_resume() and which part can be (or should be) run
> > after it.
> >=20
> > Greetings,
> > Rafael
> >=20
> >=20
> > > On 5/4/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > > On Friday, 4 May 2007 00:57, Moore, Robert wrote:
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > > > > > owner@vger.kernel.org] On Behalf Of Rafael J. Wysocki
> > > > > > Sent: Thursday, May 03, 2007 1:02 PM
> > > > > > To: ACPI Devel Maling List
> > > > > > Cc: pm list; Pavel Machek
> > > > > > Subject: Why don't we use _TTS method?
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > I've got two questions regarding the implementation of the
> ACPI
> > > > > > poweroff/sleep
> > > > > > code in drivers/acpi/sleep and drivers/acpi/hardware .
> > > > > >
> > > > > > 1) We don't seem to use the _TTS system-control method,
> although
> > the
> > > > > ACPI
> > > > > > specification (ACPI 3.0b) says that this method should be use=
d
> for
> > > > > > intiating
> > > > > > and finishing power transitions.  Could you please tell me wh=
y
> we
> > > > > don't
> > > > > > use it?
> > > > > >
> > > > > [Moore, Robert]
> > > > >
> > > > > Probably because it's fairly new and it takes a long time for
> these
> > > > > things to appear in real machines. Also, needs to be supported
> in
> > > > > Windows before we ever see it in real machines.
> > > >
> > > > Hmm, it already was in the 3.0 spec from 2004, so it doesn't seem
> to
> > be
> > > > that new.  Still, I'm not an expert ...
> > > >
> > > > > > 2) In the functions acpi_enter_sleep_state_prep(),
> > > > > > acpi_enter_sleep_state(),
> > > > > > acpi_leave_sleep_state() we manipulate GPEs quite extensively
> (we
> > > > > disable
> > > > > > and enable them for a couple of times during a transition),
> > although
> > > > > the
> > > > > > specification doesn't tell anything about that explicitly.
> Could
> > you
> > > > > > please
> > > > > > explain to me what the purpose of that is?
> > > > > >
> > > > > [Moore, Robert]
> > > > >
> > > > > There a wake GPEs and runtime GPEs that need to be managed
> > separately.
> > > > > We want to make sure that only the "Wake" GPEs are enabled as w=
e
> > goto
> > > > > sleep.
> > > >
> > > > I understand that, but the runtime GPEs seem to be disabled befor=
e
> we
> > call
> > > > device drivers' .suspend() routines (ie. before the devices are
> placed
> > in the
> > > > appropriate Dx states) and that's the point I don't quite get.  I=
s
> > there a
> > > > technical reason for doing it in this particular place?
> > > >
> > > > Thanks a lot for your reply.
> > > >
> > > > Greetings,
> > > > Rafael
> > > > -
> > > > To unsubscribe from this list: send the line "unsubscribe
> linux-acpi"
> > in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
> > > >
> > >
> > >
> >=20
> > --
> > If you don't have the time to read,
> > you don't have the time or the tools to write.
> > 		- Stephen King
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20

--=20
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
