From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpuidle: menu: allow state 0 to be disabled
Date: Thu, 29 Jun 2017 22:57:33 +0200
Message-ID: <CAJZ5v0iSX9yweQNiQ1UnnHVLt-iFZ3gJ1VyRxSOvq2+DEkWa6g@mail.gmail.com>
References: <20170626053815.11845-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:34921 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751827AbdF2U5e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2017 16:57:34 -0400
In-Reply-To: <20170626053815.11845-1-npiggin@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Jun 26, 2017 at 7:38 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
> The menu driver does not allow state0 to be disabled completely.
> If it is disabled but other enabled states don't meet latency
> requirements, it is still used.
>
> Fix this by starting with the first enabled idle state. Fall back
> to state 0 if no idle states are enabled (arguably this should be
> -EINVAL if it is attempted, but this is the minimal fix).
>
> Acked-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>
> Hi Rafael,

Hi Nick,

> This patch is helpful when measuring power draw of polling,
> latency cost of idle states, etc. Please consider merging if
> you agree.

I have a slight concern about x86 where state0 is mapped to polling
and the way it is used in general stems from that.

Still, I guess we can try and see if this causes any problems to
happen in practice, so I'm going to apply it.

Thanks,
Rafael
