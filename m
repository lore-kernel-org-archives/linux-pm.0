From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 02/10] freezer: skip waking up tasks with
	PF_FREEZER_SKIP set
Date: Tue, 30 Apr 2013 19:10:59 +0200
Message-ID: <20130430171059.GA28944@redhat.com>
References: <1367271946-7239-1-git-send-email-ccross@android.com> <1367271946-7239-3-git-send-email-ccross@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:28494 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933340Ab3D3ROZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 30 Apr 2013 13:14:25 -0400
Content-Disposition: inline
In-Reply-To: <1367271946-7239-3-git-send-email-ccross@android.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Colin Cross <ccross@android.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, arve@android.com, Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, containers@redhat.com

On 04/29, Colin Cross wrote:
>
> @@ -46,10 +46,10 @@ static int try_to_freeze_tasks(bool user_only)
>  		todo = 0;
>  		read_lock(&tasklist_lock);
>  		do_each_thread(g, p) {
> -			if (p == current || !freeze_task(p))
> +			if (p == current || freezer_should_skip(p))
>  				continue;
>
> -			if (!freezer_should_skip(p))
> +			if (freeze_task(p))
>  				todo++;

What if we race with freezer_count() ?

try_to_freeze_tasks() can wrongly succeed leaving the running task
unfrozen, no?

Oleg.

