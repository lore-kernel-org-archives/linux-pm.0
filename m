From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Why don't we use _TTS method?
Date: Fri, 4 May 2007 01:22:56 +0200
Message-ID: <200705040122.56563.rjw__23663.4753099226$1178234340$gmane$org@sisk.pl>
References: <B28E9812BAF6E2498B7EC5C427F293A40267F659@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <B28E9812BAF6E2498B7EC5C427F293A40267F659@orsmsx415.amr.corp.intel.com>
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

On Friday, 4 May 2007 00:57, Moore, Robert wrote:
> 
> > -----Original Message-----
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > owner@vger.kernel.org] On Behalf Of Rafael J. Wysocki
> > Sent: Thursday, May 03, 2007 1:02 PM
> > To: ACPI Devel Maling List
> > Cc: pm list; Pavel Machek
> > Subject: Why don't we use _TTS method?
> > 
> > Hi,
> > 
> > I've got two questions regarding the implementation of the ACPI
> > poweroff/sleep
> > code in drivers/acpi/sleep and drivers/acpi/hardware .
> > 
> > 1) We don't seem to use the _TTS system-control method, although the
> ACPI
> > specification (ACPI 3.0b) says that this method should be used for
> > intiating
> > and finishing power transitions.  Could you please tell me why we
> don't
> > use it?
> > 
> [Moore, Robert] 
> 
> Probably because it's fairly new and it takes a long time for these
> things to appear in real machines. Also, needs to be supported in
> Windows before we ever see it in real machines.

Hmm, it already was in the 3.0 spec from 2004, so it doesn't seem to be
that new.  Still, I'm not an expert ...

> > 2) In the functions acpi_enter_sleep_state_prep(),
> > acpi_enter_sleep_state(),
> > acpi_leave_sleep_state() we manipulate GPEs quite extensively (we
> disable
> > and enable them for a couple of times during a transition), although
> the
> > specification doesn't tell anything about that explicitly.  Could you
> > please
> > explain to me what the purpose of that is?
> > 
> [Moore, Robert] 
> 
> There a wake GPEs and runtime GPEs that need to be managed separately.
> We want to make sure that only the "Wake" GPEs are enabled as we goto
> sleep.

I understand that, but the runtime GPEs seem to be disabled before we call
device drivers' .suspend() routines (ie. before the devices are placed in the
appropriate Dx states) and that's the point I don't quite get.  Is there a
technical reason for doing it in this particular place?

Thanks a lot for your reply.

Greetings,
Rafael
