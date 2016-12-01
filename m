From: Len Brown <lenb@kernel.org>
Subject: Re: [RESEND PATCH 11/11] tools/power turbostat: enable turbostat to
 support Knights Mill (KNM)
Date: Thu, 1 Dec 2016 01:47:09 -0500
Message-ID: <CAJvTdKmTyVg0UeBWFggj4RsW3hbtK5e+-rAZyfHUFvwAqtEPuw@mail.gmail.com>
References: <20161013153105.2517-1-piotr.luc@intel.com> <20161013153105.2517-12-piotr.luc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161013153105.2517-12-piotr.luc@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Piotr Luc <piotr.luc@intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Doug Thompson <dougthompson@xmission.com>, Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Piotr,
Thanks for sending the patch, I've made this change to my turbostat
branch for 4.10.

I did not apply your patch directly because for some reason it didn't
appear in patchwork for linux-pm,
only for lkml, which I do not review.

Also, your patch depended on your style update patch to use the model # macros.
Unfortunately what you did not know was that I'd already applied a
slightly different style update patch.
(and it was my fault that I did not push it upstream before my summer
sabbatical, sorry)

In general, though, a good strategy when mixing style and functionality patches
is to do the functionality first.  The reason is both that style
patches tend to conflict more,
and you don't want them to hold up the functionality.
Also, if your functionality patch does not depend on style,
it is easier to backport to distros who avoid style updates.

Fortunately, this one was trivial.

thanks,
Len Brown, Intel Open Source Technology Center
