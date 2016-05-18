From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1] PM / sleep: make pm notifier called symmetrically
Date: Wed, 18 May 2016 22:34:02 +0200
Message-ID: <CAJZ5v0hT8B9k44V3KFbJPev0ORyVD2MiE=0nn8O_qdaU=QkHXg@mail.gmail.com>
References: <1463551630-9930-1-git-send-email-lianwei.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35458 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbcERUeE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 May 2016 16:34:04 -0400
In-Reply-To: <1463551630-9930-1-git-send-email-lianwei.wang@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lianwei Wang <lianwei.wang@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wed, May 18, 2016 at 8:07 AM, Lianwei Wang <lianwei.wang@gmail.com> wrote:
> This makes pm notifier PREPARE/POST symmetrical: if PREPARE
> fails, we will only undo what ever happened on PREPARE.
>
> It fixes the unbalanced cpu hotplug enable in cpu pm notifier.

Can you please describe the problem you're trying to address in a bit
more detail?
