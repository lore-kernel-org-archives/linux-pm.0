From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1] PM / sleep: make pm notifier called symmetrically
Date: Wed, 08 Jun 2016 02:40:04 +0200
Message-ID: <4137764.SdaSPLogrJ@vostro.rjw.lan>
References: <1463551630-9930-1-git-send-email-lianwei.wang@gmail.com> <CAJFUiJiuzDL9Cu5rNBXbTo9CH2hS9VuNpuV3uqZC6rkqfQMzZg@mail.gmail.com> <CAJFUiJhKJT5W_fq_hMGSG7rCUU4dx9o-H5SLiYWmktem2faj1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:46692 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750881AbcFHAgE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jun 2016 20:36:04 -0400
In-Reply-To: <CAJFUiJhKJT5W_fq_hMGSG7rCUU4dx9o-H5SLiYWmktem2faj1w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lianwei Wang <lianwei.wang@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Monday, June 06, 2016 10:41:25 PM Lianwei Wang wrote:
> On Wed, May 18, 2016 at 11:06 PM, Lianwei Wang <lianwei.wang@gmail.com> wrote:
> > On Wed, May 18, 2016 at 1:34 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >> On Wed, May 18, 2016 at 8:07 AM, Lianwei Wang <lianwei.wang@gmail.com> wrote:
> >>> This makes pm notifier PREPARE/POST symmetrical: if PREPARE
> >>> fails, we will only undo what ever happened on PREPARE.
> >>>
> >>> It fixes the unbalanced cpu hotplug enable in cpu pm notifier.
> >>
> >> Can you please describe the problem you're trying to address in a bit
> >> more detail?
> >
> > It is described in another patch, and it is a common issue. I fixed
> > the similar issue several times, all because that the CPU_POST_SUSPEND
> > notifier callback is called without call CPU_SUSPEND_PREPARE notifier
> > callback before. Something is DO in PM_XXX_PREPARE and UNDO in
> > POST_XXX. If we don't DO it in XXX_PREPARE then we don't need to UNDO
> > it in  PM_POST_XXX.
> >
> > Here is the link for the unbalanced cpu hotplug enable case:
> > https://lkml.org/lkml/2016/5/6/61 .
> >
> > Thanks,
> > Lianwei
> 
> Did anyone from the maintainer review the patch yet?

Yes, I have reviewed it, but not yet decided whether or not I will accept it.

Thanks,
Rafael

