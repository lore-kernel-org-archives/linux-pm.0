From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86: use cpufreq_quick_get() for /proc/cpuinfo "cpu MHz" again
Date: Tue, 14 Nov 2017 16:34:43 -0800
Message-ID: <CA+55aFxYQKzGbZ3GUWcuta5kz=2jp52xbEhV96R5RfCaMbLaNg@mail.gmail.com>
References: <20171109103814.70688-1-chao.wang@ucloud.cn> <CA+55aFw=JkvmxohBtVy-3QPtFibq_rv_uqp3ss+gpo8vSqYGQw@mail.gmail.com>
 <CA+55aFyRYWUn790wumcGNky98gJsDzz8W3Qna1xLC9fwcKOE=Q@mail.gmail.com> <2067351.8xeh6jAbVr@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:45862 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752929AbdKOAeo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Nov 2017 19:34:44 -0500
In-Reply-To: <2067351.8xeh6jAbVr@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, WANG Chao <chao.wang@ucloud.cn>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kate Stewart <kstewart@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Mathias Krause <minipli@googlemail.com>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Tue, Nov 14, 2017 at 4:30 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> OK, so may I queue it up?
>
> I don't think I can get that to work substantially faster anyway ...

Yeah, I think it's ok.

If somebody is really doing that /proc/cpuinfo in a loop, the rate
limiting should kick in. And if you do it only once, getting the right
frequency is worth it, I think.

             Linus
