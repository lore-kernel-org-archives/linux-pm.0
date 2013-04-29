From: Colin Cross <ccross@android.com>
Subject: Re: [PATCH 02/10] freezer: skip waking up tasks with PF_FREEZER_SKIP set
Date: Mon, 29 Apr 2013 15:02:19 -0700
Message-ID: <CAMbhsRQHkm=XTYtummEZq1h4sa-tRGwLpk8Uyhpj9D3+jQF3dg@mail.gmail.com>
References: <1367271946-7239-1-git-send-email-ccross@android.com>
	<1367271946-7239-3-git-send-email-ccross@android.com>
	<20130429215157.GA2395@htj.dyndns.org>
	<20130429215745.GB2395@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vb0-f50.google.com ([209.85.212.50]:64589 "EHLO
	mail-vb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758088Ab3D2WCU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2013 18:02:20 -0400
Received: by mail-vb0-f50.google.com with SMTP id w15so809276vbb.37
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2013 15:02:20 -0700 (PDT)
In-Reply-To: <20130429215745.GB2395@htj.dyndns.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>, Li Zefan <lizefan@huawei.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, containers@lists.linux-foundation.org, cgroups@vger.kernel.org

On Mon, Apr 29, 2013 at 2:57 PM, Tejun Heo <tj@kernel.org> wrote:
> On Mon, Apr 29, 2013 at 02:51:57PM -0700, Tejun Heo wrote:
>> I feel a bit weary of changes which try to optimize state checks for
>> freezer because the synchronization rules are kinda fragile and things
>> may not work reliably depending on who's testing the flag, and it has
>> been subtly broken in various ways in the past (maybe even now).  Can
>
> And BTW, this is why the function is only used when checking whether a
> task is frozen rather than to decide to issue freeze_task() on it, and
> it seems your change is correct now that we don't have per-task FREEZE
> flag but I can't say I like the change.  I'd really like to keep
> things as dumb as possible for freezer.

See the first patch in the series (which isn't available in the
archive yet, so I can't link to it).  The short version is that
Android goes through suspend/resume very often (every few seconds when
on a busy wifi network with the screen off), and a significant portion
of the energy used to go in and out of suspend is spent in the
freezer.  This patch series takes the most common userspace sleep
points and converts them to PF_FREEZER_SKIP, which reduces the number
of context switches for every suspend or resume event on a
freshly-booted Android device from 1000 to 25, and reduces the time
spent freezing by a factor of 5.  It will have a similar effect on a
non-Android system, although those generally don't care about
suspend/resume optimization.
