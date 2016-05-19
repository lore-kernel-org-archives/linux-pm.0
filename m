From: Lianwei Wang <lianwei.wang@gmail.com>
Subject: Re: [PATCH v1] PM / sleep: make pm notifier called symmetrically
Date: Wed, 18 May 2016 23:06:49 -0700
Message-ID: <CAJFUiJiuzDL9Cu5rNBXbTo9CH2hS9VuNpuV3uqZC6rkqfQMzZg@mail.gmail.com>
References: <1463551630-9930-1-git-send-email-lianwei.wang@gmail.com> <CAJZ5v0hT8B9k44V3KFbJPev0ORyVD2MiE=0nn8O_qdaU=QkHXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36471 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbcESGHL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2016 02:07:11 -0400
In-Reply-To: <CAJZ5v0hT8B9k44V3KFbJPev0ORyVD2MiE=0nn8O_qdaU=QkHXg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wed, May 18, 2016 at 1:34 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, May 18, 2016 at 8:07 AM, Lianwei Wang <lianwei.wang@gmail.com> wrote:
>> This makes pm notifier PREPARE/POST symmetrical: if PREPARE
>> fails, we will only undo what ever happened on PREPARE.
>>
>> It fixes the unbalanced cpu hotplug enable in cpu pm notifier.
>
> Can you please describe the problem you're trying to address in a bit
> more detail?

It is described in another patch, and it is a common issue. I fixed
the similar issue several times, all because that the CPU_POST_SUSPEND
notifier callback is called without call CPU_SUSPEND_PREPARE notifier
callback before. Something is DO in PM_XXX_PREPARE and UNDO in
POST_XXX. If we don't DO it in XXX_PREPARE then we don't need to UNDO
it in  PM_POST_XXX.

Here is the link for the unbalanced cpu hotplug enable case:
https://lkml.org/lkml/2016/5/6/61 .

Thanks,
Lianwei
