From: Thomas Garnier <thgarnie@google.com>
Subject: Re: [Resend][PATCH] x86/power/64: Always create temporary identity
 mapping correctly
Date: Wed, 10 Aug 2016 07:42:17 -0700
Message-ID: <CAJcbSZHGH8G01zXSE6y9A19ZxFYY0bzeqcfHBEAYZcn8ZeX3+g@mail.gmail.com>
References: <2206547.eDj3RJQyE5@vostro.rjw.lan> <2010434.TyoHiO9eal@vostro.rjw.lan>
 <alpine.LNX.2.00.1608100948560.22028@cbobk.fhfr.pm> <1779906.DOHeuFCiDy@vostro.rjw.lan>
 <alpine.LNX.2.00.1608101517380.22028@cbobk.fhfr.pm>
Reply-To: kernel-hardening@lists.openwall.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kernel-hardening-return-4321-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
In-Reply-To: <alpine.LNX.2.00.1608101517380.22028@cbobk.fhfr.pm>
To: Jiri Kosina <jikos@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, Pavel Machek <pavel@ucw.cz>, Kernel Hardening <kernel-hardening@lists.openwall.com>, Borislav Petkov <bpetkov@suse.de>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 10, 2016 at 6:18 AM, Jiri Kosina <jikos@kernel.org> wrote:
> On Wed, 10 Aug 2016, Rafael J. Wysocki wrote:
>
>> The last patch I sent had a problem, because if restore_jump_address really
>> overlapped with the identity mapping of the restore kernel, it might share
>> PGD or PUD entries with that mapping and that should have been taken into
>> account.
>>
>> Here goes an update.  Again, this works on my test machine, but then the
>> previous version worked on it too ...
>
> Unfortunately still exactly the same symptoms during resume even with this
> one.

What type of machines are you testing it on? What is the memory size?
Processor generation?

>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>
