From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] x86/ACPI/cstate: Output AMD on APCI C1 FFH MWAIT AMD systems
Date: Thu, 9 Aug 2018 12:25:59 -0400
Message-ID: <CAJvTdKkXTtPwvYBd5N2AGQiWcn-aAksHCht6BR+4AWP-pmGKNw@mail.gmail.com>
References: <20180808174735.3114-1-prarit@redhat.com> <20180808195856.GA20912@amd>
 <932b8a78-a7b4-ea8c-a640-b7f657f45b63@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <932b8a78-a7b4-ea8c-a640-b7f657f45b63@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

>> "ACPI FFH INTEL MWAIT 0x%x"

> Should we drop INTEL from the above or not (as suggested later in this thread)?
> It feels like everyone is on the fence about it.

Okay with me to drop the "INTEL" part of this string -- it actually
doesn't add any information.

thanks,
-Len
