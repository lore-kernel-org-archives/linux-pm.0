From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] coredump: fix unfreezable coredumping task
Date: Mon, 7 Nov 2016 14:26:08 -0800
Message-ID: <20161107142608.e4fa032b2e32b623663ff2e9@linux-foundation.org>
References: <1475225434-3753-1-git-send-email-aryabinin@virtuozzo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:42294 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751081AbcKGW0K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Nov 2016 17:26:10 -0500
In-Reply-To: <1475225434-3753-1-git-send-email-aryabinin@virtuozzo.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Oleg Nesterov <oleg@redhat.com>, linux-pm@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Fri, 30 Sep 2016 11:50:34 +0300 Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:

> It could be not possible to freeze coredumping task when it waits
> for 'core_state->startup' completion, because threads are frozen
> in get_signal() before they got a chance to complete 'core_state->startup'.
> 
> Use freezer_do_not_count() to tell freezer to ignore coredumping
> task while it waits for core_state->startup completion.
> 
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: stable@vger.kernel.org

The changelog provides no reason why this patch should be merged into
-stable.  Nor into anything else, really.

Please (as always) provide a full description of the bug's end-user
visible effects.

