From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86: use cpufreq_quick_get() for /proc/cpuinfo "cpu MHz" again
Date: Tue, 14 Nov 2017 15:02:22 -0800
Message-ID: <CA+55aFxkfh1U1kawntYUtz4u610Hcgx-HWgyL+pROzQFA+MOaw@mail.gmail.com>
References: <20171109103814.70688-1-chao.wang@ucloud.cn> <CA+55aFycTaZjKg1SGujkMrOX5WmUyWHvy2ujzaV8jefOfDPy_Q@mail.gmail.com>
 <CAJZ5v0iPt8VKoM8BuRA7O+U+fk7dg37sqVJ0pi2=S8muqfznPQ@mail.gmail.com> <2101739.Je3pS2vcJU@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:40803 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753334AbdKNXCX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Nov 2017 18:02:23 -0500
In-Reply-To: <2101739.Je3pS2vcJU@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: WANG Chao <chao.wang@ucloud.cn>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kate Stewart <kstewart@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Mathias Krause <minipli@googlemail.com>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Tue, Nov 14, 2017 at 2:47 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> So what about the one below?  It works for me as expected.

Can somebody with 100+ cores test this? Ingo? You had a 160 core
machine that took forever, didn't you..

            Linus
