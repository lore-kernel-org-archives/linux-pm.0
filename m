From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/3] cpuidle: powernv: Don't bounce between low and very
 low thread priority
Date: Tue, 4 Apr 2017 09:52:07 +1000
Message-ID: <20170404095207.28fc5229@roar.ozlabs.ibm.com>
References: <20170403215414.16951-1-anton@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36840 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751891AbdDCXwT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Apr 2017 19:52:19 -0400
Received: by mail-pg0-f66.google.com with SMTP id 81so33067585pgh.3
        for <linux-pm@vger.kernel.org>; Mon, 03 Apr 2017 16:52:19 -0700 (PDT)
In-Reply-To: <20170403215414.16951-1-anton@ozlabs.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anton Blanchard <anton@ozlabs.org>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, rjw@rjwysocki.net, daniel.lezcano@linaro.org, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org

On Tue,  4 Apr 2017 07:54:12 +1000
Anton Blanchard <anton@ozlabs.org> wrote:

> From: Anton Blanchard <anton@samba.org>
> 
> The core of snooze_loop() continually bounces between low and very
> low thread priority. Changing thread priorities is an expensive
> operation that can negatively impact other threads on a core.
> 
> All CPUs that can run PowerNV support very low priority, so we can
> avoid the change completely.

This looks good. I have HMT_lowest() which does alt feature patching
we can use for pseries and default idle code.
