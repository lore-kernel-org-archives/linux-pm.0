From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86: use cpufreq_quick_get() for /proc/cpuinfo "cpu MHz" again
Date: Tue, 14 Nov 2017 16:06:12 -0800
Message-ID: <CA+55aFyRYWUn790wumcGNky98gJsDzz8W3Qna1xLC9fwcKOE=Q@mail.gmail.com>
References: <20171109103814.70688-1-chao.wang@ucloud.cn> <CA+55aFycTaZjKg1SGujkMrOX5WmUyWHvy2ujzaV8jefOfDPy_Q@mail.gmail.com>
 <CAJZ5v0iPt8VKoM8BuRA7O+U+fk7dg37sqVJ0pi2=S8muqfznPQ@mail.gmail.com>
 <2101739.Je3pS2vcJU@aspire.rjw.lan> <CA+55aFxkfh1U1kawntYUtz4u610Hcgx-HWgyL+pROzQFA+MOaw@mail.gmail.com>
 <alpine.DEB.2.20.1711150038120.2221@nanos> <CA+55aFw=JkvmxohBtVy-3QPtFibq_rv_uqp3ss+gpo8vSqYGQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:35681 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbdKOAGN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Nov 2017 19:06:13 -0500
In-Reply-To: <CA+55aFw=JkvmxohBtVy-3QPtFibq_rv_uqp3ss+gpo8vSqYGQw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, WANG Chao <chao.wang@ucloud.cn>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kate Stewart <kstewart@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Mathias Krause <minipli@googlemail.com>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Tue, Nov 14, 2017 at 4:04 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Nov 14, 2017 at 3:53 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> Current head + Raphaels patch:
>>
>> real    0m0.029s
>> user    0m0.000s
>> sys     0m0.010s
>>
>> So that patch is actually slower.
>
> Oh it definitely is expected to be slower, because it does the IPI to
> all the cores and actually gets their frequency right.
>
> It was the old one that we had to revert (because it did so
> sequentially) that was really bad, and took something like 2+ seconds
> on Ingo's 160-core thing, iirc.

Looked it up. Ingo's machine "only" had 120 cores, and he said

    fomalhaut:~> time cat /proc/cpuinfo  >/dev/null
    real    0m2.689s

for the bad serial case, so yeah, it looks "a bit" better than it was ;)

             Linus
