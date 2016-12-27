From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] intel_idle: work around errate VLP52 on Baytrail CPUs
Date: Tue, 27 Dec 2016 15:37:26 -0500
Message-ID: <CAJvTdK=sFHRo3FQ-ebWM7qVY3iLadWUFA+iacB8jwfHtJyNWGA@mail.gmail.com>
References: <838trb233m.fsf@echidna.jochen.org> <CAJZ5v0jkATWSrGuR_DOfiSUFguRJ1w7gMRth1kjwYh1bSWnvGw@mail.gmail.com>
 <CA+8K-g=fXN9TWWxkV1AEEjXJLhwJEQ2PB434gKQ9Z7bL=yf+zA@mail.gmail.com> <CA+8K-g=VVC-13J+jU+KGyk49xHPhm5uojj0h9FcWZiC91NTiQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34196 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755038AbcL0Uh2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Dec 2016 15:37:28 -0500
Received: by mail-qk0-f196.google.com with SMTP id t184so29950829qkd.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Dec 2016 12:37:27 -0800 (PST)
In-Reply-To: <CA+8K-g=VVC-13J+jU+KGyk49xHPhm5uojj0h9FcWZiC91NTiQw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Gerris <vgerris@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jochen Hein <jochen@jochen.org>, Linux PM <linux-pm@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>

>>> On Mon, Dec 19, 2016 at 7:19 PM, Jochen Hein <jochen@jochen.org> wrote:
>>> >
>>> > There are frequent hangs on Baytrail CPUs according to
>>> > https://bugzilla.kernel.org/show_bug.cgi?id=109051.
>>> > This patch works around the errata by disabling C6.
>>> >
>>> > According to the discussion in the bug and private mail it might be
>>> > useful to include the workaround in mainline.
>>> >
>>> > Signed-off-by: Jochen Hein <jochen@jochen.org>
>>> > Cc: stable@vger.kernel.org
>>> >
>>> > --- linux-4.7.5/drivers/idle/intel_idle.c.orig  2016-09-24 10:10:18.000000000 +0200
>>> > +++ linux-4.7.5/drivers/idle/intel_idle.c       2016-10-16 07:36:51.142862573 +0200
>>> > @@ -1210,6 +1210,34 @@
>>> >
>>> >  }
>>> >  /*
>>> > + * byt_idle_state_table_update(void)
>>> > + *
>>> > + * On BYT, we have errata VLP52 and disable C6.
>>> > + * https://bugzilla.kernel.org/show_bug.cgi?id=109051A
>>> > + * http://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/pentium-n3520-j2850-celeron-n2920-n2820-n2815-n2806-j1850-j1750-spec-update.pdf
>>> > + * VLP52 EOI Transactions May Not be Sent if Software Enters Core C6 During an Interrupt Service Routine.
>>> > +
>>> > +Problem:
>>> > +If core C6 is entered after the start of an interrupt service routine but before a write
>>> > +to the APIC EOI (End of Interrupt) register, and the core is woken up by an event
>>> > +other than a fixed interrupt source the core may drop the EOI transaction the next
>>> > +time APIC EOI register is written and further interrupts from the same or lower
>>> > +priority level will be blocked.
>>> > +
>>> > +Implication:
>>> > +EOI transactions may be lost and interrupts may be blocked when core C6 is used
>>> > +during interrupt service routines.

Exactly how is it possible for Linux to enter idle and issue an MWAIT
from _within_ an interrupt handler?

>>> > +Workaround:
>>> > +It is possible for the firmware to contain a workaround for this erratum.
>>> > + */
>>> > +static void byt_idle_state_table_update(void)
>>> > +{
>>> > +       printk(PREFIX "byt_idle_state_table_update reached\n");
>>> > +       byt_cstates[1].disabled = 1;    /* C6N-BYT */
>>> > +       byt_cstates[2].disabled = 1;    /* C6S-BYT */
>>> > +}
>>> > +/*
>>> >   * sklh_idle_state_table_update(void)
>>> >   *
>>> >   * On SKL-H (model 0x5e) disable C8 and C9 if:
>>> > @@ -1264,6 +1292,10 @@
>>> >         case 0x3e: /* IVT */
>>> >                 ivt_idle_state_table_update();
>>> >                 break;
>>> > +       case 0x37: /* BYT */
>>> > +               printk(PREFIX "intel_idle_state_table_update BYT 0x37 reached\n");
>>> > +               byt_idle_state_table_update();
>>> > +               break;

If the right strategy were to disable C6 for all of BYT, then the
right implementation
would be to delete those states from byt_cstates[], rather than for a
routine to mark
them as disabled.  Note that a user can not later enable a state that is marked
as disabled here, it is never registered with cpuidle, and thus the effect
is exactly the same as if the entry were never in the table in the first place.

>>> >         case 0x5c: /* BXT */
>>> >                 bxt_idle_state_table_update();
>>> >                 break;
>>> >

thanks,
Len Brown, Intel Open Source Technology Center
