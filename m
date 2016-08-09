From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [Resend][PATCH] x86/power/64: Always create temporary identity
 mapping correctly
Date: Tue, 9 Aug 2016 23:23:31 +0200
Message-ID: <CAJZ5v0hWRH0zVjNDH6cjNn8kSSXSW0qc-aQZ8p_5EVS3cajcQA@mail.gmail.com>
References: <2206547.eDj3RJQyE5@vostro.rjw.lan> <alpine.LRH.2.00.1608091121120.19185@gjva.wvxbf.pm>
 <CAJZ5v0iAiQwpBgY=4hH-RsBB54tD8FY4C8pWbjNNRmAjJ9Xg+Q@mail.gmail.com>
 <alpine.LNX.2.00.1608091457370.22028@cbobk.fhfr.pm> <alpine.LNX.2.00.1608091525540.22028@cbobk.fhfr.pm>
 <CAJcbSZHdTJC8ys-rhi19k+gmxe+U3m_e+i4aRTuuyV18r6ukCA@mail.gmail.com>
 <alpine.LNX.2.00.1608091702240.22028@cbobk.fhfr.pm> <CAJZ5v0hciyV01GMxBV6fQmdXRrZYbkDb9_JUoLPh1+EwG0oRow@mail.gmail.com>
 <alpine.LNX.2.00.1608092119260.22028@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35443 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932338AbcHIVXe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Aug 2016 17:23:34 -0400
In-Reply-To: <alpine.LNX.2.00.1608092119260.22028@cbobk.fhfr.pm>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Garnier <thgarnie@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>, Pavel Machek <pavel@ucw.cz>, Kernel Hardening <kernel-hardening@lists.openwall.com>, Borislav Petkov <bpetkov@suse.de>

On Tue, Aug 9, 2016 at 10:02 PM, Jiri Kosina <jikos@kernel.org> wrote:
> On Tue, 9 Aug 2016, Rafael J. Wysocki wrote:
>
>> I have a murky suspicion, but it is really weird.  Namely, what if
>> restore_jump_address in set_up_temporary_text_mapping() happens to be
>> covered by the restore kernel's identity mapping?  Then, the image
>> kernel's entry point may get overwritten by something else in
>> core_restore_code().
>
> So this made me to actually test a scenario where I'd suspend a kernel
> that's known-broken (i.e. contains 021182e52fe), and then have it resumed
> by a kernel that has 021182e52fe reverted. It resumed successfully.
>
> Just a datapoint.

That indicates the problem is somewhere in the restore kernel and no
surprises there.

I am able to reproduce the original problem (a triple fault on resume
with CONFIG_RANDOMIZE_MEMORY set) without the $subject patch, but the
patch fixes it for me.

Question is why it is not sufficient for you and Boris and the above
theory is about the only one I can come up with ATM.

I'm going to compare the configs etc, but I guess I just end up
writing a patch to test that theory unless someone has any other idea
in the meantime.

Thanks,
Rafael
