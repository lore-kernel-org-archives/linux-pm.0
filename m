From: Jochen Hein <jochen@jochen.org>
Subject: Re: [PATCH] intel_idle: work around errate VLP52 on Baytrail CPUs
Date: Tue, 27 Dec 2016 21:44:16 +0100
Message-ID: <83ful9yue7.fsf@echidna.jochen.org>
References: <838trb233m.fsf@echidna.jochen.org>
        <CAJZ5v0jkATWSrGuR_DOfiSUFguRJ1w7gMRth1kjwYh1bSWnvGw@mail.gmail.com>
        <CA+8K-g=fXN9TWWxkV1AEEjXJLhwJEQ2PB434gKQ9Z7bL=yf+zA@mail.gmail.com>
        <CA+8K-g=VVC-13J+jU+KGyk49xHPhm5uojj0h9FcWZiC91NTiQw@mail.gmail.com>
        <CAJvTdK=sFHRo3FQ-ebWM7qVY3iLadWUFA+iacB8jwfHtJyNWGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.dinoex.de ([188.40.204.4]:17029 "EHLO smtp.dinoex.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751643AbcL0Up7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 27 Dec 2016 15:45:59 -0500
In-Reply-To: <CAJvTdK=sFHRo3FQ-ebWM7qVY3iLadWUFA+iacB8jwfHtJyNWGA@mail.gmail.com>
        (Len Brown's message of "Tue, 27 Dec 2016 15:37:26 -0500")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Vincent Gerris <vgerris@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>


Hi Len,

Len Brown <lenb@kernel.org> writes:

>>>> On Mon, Dec 19, 2016 at 7:19 PM, Jochen Hein <jochen@jochen.org> wrote:
>>>> >
>>>> > There are frequent hangs on Baytrail CPUs according to
>>>> > https://bugzilla.kernel.org/show_bug.cgi?id=109051.
>>>> > This patch works around the errata by disabling C6.

>>>> > +Problem:
>>>> > +If core C6 is entered after the start of an interrupt service routine but before a write
>>>> > +to the APIC EOI (End of Interrupt) register, and the core is woken up by an event
>>>> > +other than a fixed interrupt source the core may drop the EOI transaction the next
>>>> > +time APIC EOI register is written and further interrupts from the same or lower
>>>> > +priority level will be blocked.
>>>> > +
>>>> > +Implication:
>>>> > +EOI transactions may be lost and interrupts may be blocked when core C6 is used
>>>> > +during interrupt service routines.
>
> Exactly how is it possible for Linux to enter idle and issue an MWAIT
> from _within_ an interrupt handler?

I really have no idea - all I can say is that for all Kernels < 4.9 I
had to disable C6 to have a stable system.
4.9 seems stable for me now.

>>>> > +Workaround:
>>>> > +It is possible for the firmware to contain a workaround for this erratum.
>>>> > + */
>>>> > +static void byt_idle_state_table_update(void)
>>>> > +{
>>>> > +       printk(PREFIX "byt_idle_state_table_update reached\n");
>>>> > +       byt_cstates[1].disabled = 1;    /* C6N-BYT */
>>>> > +       byt_cstates[2].disabled = 1;    /* C6S-BYT */
>>>> > +}
>>>> > +/*
>>>> >   * sklh_idle_state_table_update(void)
>>>> >   *
>>>> >   * On SKL-H (model 0x5e) disable C8 and C9 if:
>>>> > @@ -1264,6 +1292,10 @@
>>>> >         case 0x3e: /* IVT */
>>>> >                 ivt_idle_state_table_update();
>>>> >                 break;
>>>> > +       case 0x37: /* BYT */
>>>> > +               printk(PREFIX "intel_idle_state_table_update BYT 0x37 reached\n");
>>>> > +               byt_idle_state_table_update();
>>>> > +               break;
>
> If the right strategy were to disable C6 for all of BYT, then the
> right implementation
> would be to delete those states from byt_cstates[], rather than for a
> routine to mark
> them as disabled.  Note that a user can not later enable a state that is marked
> as disabled here, it is never registered with cpuidle, and thus the effect
> is exactly the same as if the entry were never in the table in the first place.

Would that be a useful workaround for older stable kernels? I think we
should try to get stable systems to the affected users.

Jochen

-- 
The only problem with troubleshooting is that the trouble shoots back.
