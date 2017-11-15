From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86: use cpufreq_quick_get() for /proc/cpuinfo "cpu MHz" again
Date: Wed, 15 Nov 2017 09:27:07 -0800
Message-ID: <CA+55aFzHqhxzv1p7fqdXPugMUVRyM44pL4KO3f_T6yFJUACXvw@mail.gmail.com>
References: <20171109103814.70688-1-chao.wang@ucloud.cn> <CA+55aFw=JkvmxohBtVy-3QPtFibq_rv_uqp3ss+gpo8vSqYGQw@mail.gmail.com>
 <CA+55aFyRYWUn790wumcGNky98gJsDzz8W3Qna1xLC9fwcKOE=Q@mail.gmail.com>
 <2067351.8xeh6jAbVr@aspire.rjw.lan> <20171115074358.4jf4sjpq4ffmhmpi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:46482 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758764AbdKOR1J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2017 12:27:09 -0500
In-Reply-To: <20171115074358.4jf4sjpq4ffmhmpi@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, WANG Chao <chao.wang@ucloud.cn>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kate Stewart <kstewart@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Mathias Krause <minipli@googlemail.com>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Tue, Nov 14, 2017 at 11:43 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
> I also think that /proc/cpuinfo is a pretty bad interface for many uses - I
> personally only very rarely need the cpuinfo of _all_ CPUs.
>
> We we should eventually have /proc/cpu/N/info or so, so that 99% of the times
> cpuinfo is needed to report bugs we can do:
>
>         cat /proc/cpu/0/info

I don't disagree in theory, and I used to enthusiastically support the
"let's make one value per file" model.

But in practice it's a pain, and I no longer really think it's viable
except for debugging.

As an example, I can do

  cat /proc/cpuinfo | grep MHz

and get a nice overview of what's going on. If I were a system stat
program, I'd do that too.

In contrast, tell me where in /sys something useful is?

Honestly, the /sys directory structure _looks_ much more organized,
and it's lovely for some things, but it's a confusing jungle, and
finding things there is a complete and utter pain.

Yes, you can get the same thing:

     cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq

but here's the deal: time that on your 120-core machine some day.

In other words, /proc/cpuinfo is not perfect. But the "let's split
things out" really doesn't work either. It's worse. It _sounds_ good
in theory, but it really really sucks.

I'm convinced that /sys is wonderful for management purposes. But no,
this whole "we should have individual files" is often a huge huge
mistake.

In fact, I think the current patch for CPU MHz shows exactly why
/proc/cpuinfo is actually hugely superior to the crazy "one file per
cpu" model: we could gather the statistics in parallel, all together,
and make it be reasonable.

Again, try that "cat" example again, and time it.

(And yes, I also know that "cpu*/cpufreq" is a symlink, but the direct
names are illogical, and no faster for me. Try it if you like:

  time cat /sys/devices/system/cpu/cpufreq/policy*/scaling_cur_freq > /dev/null

and then look at /proc/cpuinfo again, and realize how lovely that
human-readable file actually is).

                      Linus
