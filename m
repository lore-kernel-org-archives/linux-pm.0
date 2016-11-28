From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/4] Misc enhancements to intel_powerclamp
Date: Tue, 29 Nov 2016 00:14:41 +0100
Message-ID: <CAJZ5v0iV8EXL_wrAcxjtSkbtV_4erzGLezW5sc_ru_SuSKGqcw@mail.gmail.com>
References: <1480369492-23901-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wj0-f194.google.com ([209.85.210.194]:35428 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755318AbcK1XOp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2016 18:14:45 -0500
In-Reply-To: <1480369492-23901-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Petr Mladek <pmladek@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

On Mon, Nov 28, 2016 at 10:44 PM, Jacob Pan
<jacob.jun.pan@linux.intel.com> wrote:
> This patchset is applicable on top of scheduler support of forced idle
> tasks. (https://lkml.org/lkml/2016/11/28/683)
>
> Jacob Pan (1):
>   thermal/intel_powerclamp: stop sched tick in forced idle
>
> Petr Mladek (2):
>   thermal/intel_powerclamp: Remove duplicated code that starts the
>     kthread
>   thermal/intel_powerclamp: Convert the kthread to kthread worker API
>
> Sebastian Andrzej Siewior (1):
>   thermal/intel_powerclamp: Convert to CPU hotplug state
>

If you resend patched from other people and signed-off by them, you
also should sign the patches off as an indication that they have gone
through your hands.

Thanks,
Rafael
