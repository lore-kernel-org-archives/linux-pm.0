From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Getting rid of freezer for suspend [was Re: [fuse-devel] [PATCH]
 fuse: make fuse daemon frozen along with kernel threads]
Date: Thu, 14 Feb 2013 14:09:50 +0100
Message-ID: <CAJfpeguV5X1pwb-E7vzVtK4n0Q6Mu6A4XKnS5-tWn4Q7MtzgZg@mail.gmail.com>
References: <1360113112.17267.1.camel@fli24-HP-Compaq-8100-Elite-CMT-PC>
	<24327774.p6haZy6gvA@vostro.rjw.lan>
	<CAJfpegtUOCTNR-uzrFBcFY3K8to2+y3hvJx=vuBYS7emzU-SRA@mail.gmail.com>
	<2891124.QXsiBPuYKW@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:33264 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934270Ab3BNNJx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 Feb 2013 08:09:53 -0500
Received: by mail-lb0-f169.google.com with SMTP id m4so1771951lbo.28
        for <linux-pm@vger.kernel.org>; Thu, 14 Feb 2013 05:09:51 -0800 (PST)
In-Reply-To: <2891124.QXsiBPuYKW@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, Goswin von Brederlow <goswin-v-b@web.de>, Li Fei <fei.li@intel.com>, len.brown@intel.com, mingo@redhat.com, peterz@infradead.org, biao.wang@intel.com, linux-pm@vger.kernel.org, fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com

On Thu, Feb 14, 2013 at 1:11 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Thursday, February 14, 2013 11:41:16 AM Miklos Szeredi wrote:

>>
>> It is essentially the same mechanism that is used to delay the
>> freezing of kernel threads after userspace tasks have been frozen.
>> Except it's a lot more difficult to determine which userspace tasks
>> need to be suspended late and which aren't.
>
> Well, I suppose that information is available to user space.
>
> Do we need an interface for a process to mark itself as PF_FREEZE_LATE or
> do we need an interface for one process to mark another process as
> PF_FREEZE_LATE, or both?

As a first step marking self with PF_FREEZE_LATE and inheriting this
flag across fork/clone would work for most cases, I think.

Marking an unrelated process would have all sorts of issues: Who has
permission to do this?  Won't it be misused to "fix" random freezer
issues.

Thanks,
Miklos
