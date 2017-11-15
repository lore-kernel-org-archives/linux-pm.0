From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86: use cpufreq_quick_get() for /proc/cpuinfo "cpu MHz"
 again
Date: Wed, 15 Nov 2017 19:05:22 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1711151903260.1805@nanos>
References: <20171109103814.70688-1-chao.wang@ucloud.cn> <CA+55aFw=JkvmxohBtVy-3QPtFibq_rv_uqp3ss+gpo8vSqYGQw@mail.gmail.com> <CA+55aFyRYWUn790wumcGNky98gJsDzz8W3Qna1xLC9fwcKOE=Q@mail.gmail.com> <2067351.8xeh6jAbVr@aspire.rjw.lan> <20171115074358.4jf4sjpq4ffmhmpi@gmail.com>
 <CA+55aFzHqhxzv1p7fqdXPugMUVRyM44pL4KO3f_T6yFJUACXvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:42796 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756208AbdKOSGV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2017 13:06:21 -0500
In-Reply-To: <CA+55aFzHqhxzv1p7fqdXPugMUVRyM44pL4KO3f_T6yFJUACXvw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, WANG Chao <chao.wang@ucloud.cn>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kate Stewart <kstewart@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Mathias Krause <minipli@googlemail.com>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Wed, 15 Nov 2017, Linus Torvalds wrote:
> On Tue, Nov 14, 2017 at 11:43 PM, Ingo Molnar <mingo@kernel.org> wrote:
> Again, try that "cat" example again, and time it.
> 
> (And yes, I also know that "cpu*/cpufreq" is a symlink, but the direct
> names are illogical, and no faster for me. Try it if you like:
> 
>   time cat /sys/devices/system/cpu/cpufreq/policy*/scaling_cur_freq > /dev/null

Just for the fun of it I tried. It's exactly the same time as /proc/cpuinfo
with the reverted patch which did the full IPI thing, i.e. >4 seconds on
that machine.

Not a surprise because those files do the full IPI thing as well.

Thanks,

	tglx
