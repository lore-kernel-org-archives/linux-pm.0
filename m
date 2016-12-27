From: Vincent Gerris <vgerris@gmail.com>
Subject: Re: [PATCH] intel_idle: work around errate VLP52 on Baytrail CPUs
Date: Tue, 27 Dec 2016 18:24:10 +0100
Message-ID: <CA+8K-g=VVC-13J+jU+KGyk49xHPhm5uojj0h9FcWZiC91NTiQw@mail.gmail.com>
References: <838trb233m.fsf@echidna.jochen.org> <CAJZ5v0jkATWSrGuR_DOfiSUFguRJ1w7gMRth1kjwYh1bSWnvGw@mail.gmail.com>
 <CA+8K-g=fXN9TWWxkV1AEEjXJLhwJEQ2PB434gKQ9Z7bL=yf+zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:36238 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754570AbcL0RYN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Dec 2016 12:24:13 -0500
Received: by mail-wj0-f195.google.com with SMTP id j10so52190146wjb.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Dec 2016 09:24:11 -0800 (PST)
In-Reply-To: <CA+8K-g=fXN9TWWxkV1AEEjXJLhwJEQ2PB434gKQ9Z7bL=yf+zA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jochen Hein <jochen@jochen.org>, Len Brown <lenb@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>

Hi,

Apologies, I apparently send some HTML in the email.
Here is another attempt.

Kind regards,
Vincent

---------- Forwarded message ----------
From: "Vincent Gerris" <vgerris@gmail.com>
Date: Dec 27, 2016 11:47
Subject: Re: [PATCH] intel_idle: work around errate VLP52 on Baytrail CPUs
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Jochen Hein" <jochen@jochen.org>, "Len Brown" <lenb@kernel.org>,
"Linux PM" <linux-pm@vger.kernel.org>, "Jacob Pan"
<jacob.jun.pan@linux.intel.com>, "Hans de Goede" <hdegoede@redhat.com>


>
> > Hi all,

>
> Thank you Jochen Hein for creating the patch.
> The patch fixed my problem and at least one other person with a N3530 processor.
>
> I attached a patch for 4.8.x (needed some changes to constants) which also can be found here:
> https://bugzilla.kernel.org/attachment.cgi?id=247621
> I also added Hans de Goede in de CC, he supplied patches for the Cherry trail platform.
>
> Is there anything we can do to accelerate adoption in the main kernel?
> Maybe Jacob can confirm it deals with the errata properly?
>
> Thanks everyone,
>
> Kind regards,
> Vincent
>
>
> On Mon, Dec 19, 2016 at 8:43 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:

>

> >>

>> CC Jacob Pan.
>>
>> On Mon, Dec 19, 2016 at 7:19 PM, Jochen Hein <jochen@jochen.org> wrote:
>> >
>> > There are frequent hangs on Baytrail CPUs according to
>> > https://bugzilla.kernel.org/show_bug.cgi?id=109051.
>> > This patch works around the errata by disabling C6.
>> >
>> > According to the discussion in the bug and private mail it might be
>> > useful to include the workaround in mainline.
>> >
>> > Signed-off-by: Jochen Hein <jochen@jochen.org>
>> > Cc: stable@vger.kernel.org
>> >
>> > --- linux-4.7.5/drivers/idle/intel_idle.c.orig  2016-09-24 10:10:18.000000000 +0200
>> > +++ linux-4.7.5/drivers/idle/intel_idle.c       2016-10-16 07:36:51.142862573 +0200
>> > @@ -1210,6 +1210,34 @@
>> >
>> >  }
>> >  /*
>> > + * byt_idle_state_table_update(void)
>> > + *
>> > + * On BYT, we have errata VLP52 and disable C6.
>> > + * https://bugzilla.kernel.org/show_bug.cgi?id=109051A
>> > + * http://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/pentium-n3520-j2850-celeron-n2920-n2820-n2815-n2806-j1850-j1750-spec-update.pdf
>> > + * VLP52 EOI Transactions May Not be Sent if Software Enters Core C6 During an Interrupt Service Routine.
>> > +
>> > +Problem:
>> > +If core C6 is entered after the start of an interrupt service routine but before a write
>> > +to the APIC EOI (End of Interrupt) register, and the core is woken up by an event
>> > +other than a fixed interrupt source the core may drop the EOI transaction the next
>> > +time APIC EOI register is written and further interrupts from the same or lower
>> > +priority level will be blocked.
>> > +
>> > +Implication:
>> > +EOI transactions may be lost and interrupts may be blocked when core C6 is used
>> > +during interrupt service routines.
>> > +
>> > +Workaround:
>> > +It is possible for the firmware to contain a workaround for this erratum.
>> > + */
>> > +static void byt_idle_state_table_update(void)
>> > +{
>> > +       printk(PREFIX "byt_idle_state_table_update reached\n");
>> > +       byt_cstates[1].disabled = 1;    /* C6N-BYT */
>> > +       byt_cstates[2].disabled = 1;    /* C6S-BYT */
>> > +}
>> > +/*
>> >   * sklh_idle_state_table_update(void)
>> >   *
>> >   * On SKL-H (model 0x5e) disable C8 and C9 if:
>> > @@ -1264,6 +1292,10 @@
>> >         case 0x3e: /* IVT */
>> >                 ivt_idle_state_table_update();
>> >                 break;
>> > +       case 0x37: /* BYT */
>> > +               printk(PREFIX "intel_idle_state_table_update BYT 0x37 reached\n");
>> > +               byt_idle_state_table_update();
>> > +               break;
>> >         case 0x5c: /* BXT */
>> >                 bxt_idle_state_table_update();
>> >                 break;
>> >
>> > --
>> > The only problem with troubleshooting is that the trouble shoots back.
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
