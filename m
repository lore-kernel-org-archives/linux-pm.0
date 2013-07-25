From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] power: set PF_SUSPEND_TASK flag on tasks that call freeze_processes
Date: Thu, 25 Jul 2013 16:51:20 -0700
Message-ID: <CA+55aFzGwoYq+BRBx23045AG=fWzVEtGcN-7xBTi9o=rkGhU3A@mail.gmail.com>
References: <1374712893-14487-1-git-send-email-ccross@android.com>
	<17002595.Gazy686Cvx@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vb0-f47.google.com ([209.85.212.47]:49681 "EHLO
	mail-vb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755252Ab3GYXvX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2013 19:51:23 -0400
In-Reply-To: <17002595.Gazy686Cvx@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Colin Cross <ccross@android.com>, lkml <linux-kernel@vger.kernel.org>, Michael Leun <lkml20130126@newton.leun.net>, Pavel Machek <pavel@ucw.cz>, Linux PM list <linux-pm@vger.kernel.org>, Darren Hart <dvhart@linux.intel.com>

On Thu, Jul 25, 2013 at 1:06 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>
> Can we spend an extra process flag on that?

I suspect we can. But if somebody hollers later, we'll need to do some
compaction..

              Linus
