From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] x86/ACPI/cstate: Output AMD on APCI C1 FFH MWAIT AMD systems
Date: Wed, 8 Aug 2018 16:01:41 -0400
Message-ID: <CAJvTdKnOTi-iQ9BfMW4KQWkqPU=3JRCM-9Kij+3zB5KFMjve9w@mail.gmail.com>
References: <20180808174735.3114-1-prarit@redhat.com> <20180808195856.GA20912@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180808195856.GA20912@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

I think it is sufficient to simply delete the "INTEL" in that string.

In the unlikely event that this "change to a kernel API" breaks
something, we can add it back.

-Len

On Wed, Aug 8, 2018 at 3:59 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Wed 2018-08-08 13:47:35, Prarit Bhargava wrote:
> > commit 5209654a46ee ("x86/ACPI/cstate: Allow ACPI C1 FFH MWAIT use on AMD
> > systems") allows use of FFH for ACPI C1 but tools like cpupower and turbostat
> > display INTEL for the cstate description.
> >
> > Output "AMD" for AMD systems with FFH for ACPI C1.
>
> Um, is it good idea?
>
> First, you are changing kernel API.
>
> > @@ -107,9 +108,14 @@ static long acpi_processor_ffh_cstate_probe_cpu(void *_cx)
> >                       "Monitor-Mwait will be used to enter C-%d state\n",
> >                       cx->type);
> >       }
> > -     snprintf(cx->desc,
> > -                     ACPI_CX_DESC_LEN, "ACPI FFH INTEL MWAIT 0x%x",
> > -                     cx->address);
> > +     if (c->x86_vendor == X86_VENDOR_INTEL)
> > +             snprintf(cx->desc,
> > +                      ACPI_CX_DESC_LEN, "ACPI FFH INTEL MWAIT 0x%x",
> > +                      cx->address);
> > +     else
> > +             snprintf(cx->desc,
> > +                      ACPI_CX_DESC_LEN, "ACPI FFH AMD MWAIT 0x%x",
> > +                      cx->address);
>
> Second, I read it as "Intel MWAIT" instruction is used. Yes, AMD cpu can
> use Intel MWAIT, too...
>
> Third, there are more CPU vendors out there.
>
>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html



-- 
Len Brown, Intel Open Source Technology Center
