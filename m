From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Why don't we use _TTS method?
Date: Fri, 4 May 2007 10:50:40 +0200
Message-ID: <200705041050.41439.rjw__15606.7249052741$1178268447$gmane$org@sisk.pl>
References: <B28E9812BAF6E2498B7EC5C427F293A40267F659@orsmsx415.amr.corp.intel.com>
	<200705040122.56563.rjw@sisk.pl>
	<8f8ff01d0705032134s4758d675qe1b37febb5745770@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <8f8ff01d0705032134s4758d675qe1b37febb5745770@mail.gmail.com>
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
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, "Moore,
	Robert" <robert.moore@intel.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi Alexey,

On Friday, 4 May 2007 06:34, Alexey Starikovskiy wrote:
> Rafael,
> 
> code in prepare() and enter() is split as code with interrupts on and
> code with interrupts off.

I see.  Still, the spec seems to suggest that _GTS should be executed with
interrupts off, but we run it in the 'interrupts on' part of code.  Isn't that
wrong?

> thus it doesn't quite follow a spec in regards of driver suspend.

Yes.

> Basically we need to either split it to smaller pieces or have hooks
> to control interrupts/driver suspend from this code.

I'd like to split it and I'd like to figure out *how* to do this.  More
precisely, I'd like to learn which part of acpi_pm_prepare() should be
executed before device_suspend() and which part can be run after it.
Analogously, I'd like to learn which part of acpi_pm_finish() needs to be
run before device_resume() and which part can be (or should be) run
after it.

Greetings,
Rafael


> On 5/4/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Friday, 4 May 2007 00:57, Moore, Robert wrote:
> > >
> > > > -----Original Message-----
> > > > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > > > owner@vger.kernel.org] On Behalf Of Rafael J. Wysocki
> > > > Sent: Thursday, May 03, 2007 1:02 PM
> > > > To: ACPI Devel Maling List
> > > > Cc: pm list; Pavel Machek
> > > > Subject: Why don't we use _TTS method?
> > > >
> > > > Hi,
> > > >
> > > > I've got two questions regarding the implementation of the ACPI
> > > > poweroff/sleep
> > > > code in drivers/acpi/sleep and drivers/acpi/hardware .
> > > >
> > > > 1) We don't seem to use the _TTS system-control method, although the
> > > ACPI
> > > > specification (ACPI 3.0b) says that this method should be used for
> > > > intiating
> > > > and finishing power transitions.  Could you please tell me why we
> > > don't
> > > > use it?
> > > >
> > > [Moore, Robert]
> > >
> > > Probably because it's fairly new and it takes a long time for these
> > > things to appear in real machines. Also, needs to be supported in
> > > Windows before we ever see it in real machines.
> >
> > Hmm, it already was in the 3.0 spec from 2004, so it doesn't seem to be
> > that new.  Still, I'm not an expert ...
> >
> > > > 2) In the functions acpi_enter_sleep_state_prep(),
> > > > acpi_enter_sleep_state(),
> > > > acpi_leave_sleep_state() we manipulate GPEs quite extensively (we
> > > disable
> > > > and enable them for a couple of times during a transition), although
> > > the
> > > > specification doesn't tell anything about that explicitly.  Could you
> > > > please
> > > > explain to me what the purpose of that is?
> > > >
> > > [Moore, Robert]
> > >
> > > There a wake GPEs and runtime GPEs that need to be managed separately.
> > > We want to make sure that only the "Wake" GPEs are enabled as we goto
> > > sleep.
> >
> > I understand that, but the runtime GPEs seem to be disabled before we call
> > device drivers' .suspend() routines (ie. before the devices are placed in the
> > appropriate Dx states) and that's the point I don't quite get.  Is there a
> > technical reason for doing it in this particular place?
> >
> > Thanks a lot for your reply.
> >
> > Greetings,
> > Rafael
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> 

-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
