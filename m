From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Subject: Re: [PATCH] thermal: Fix improper clock_cooling header guard
Date: Wed, 28 Jun 2017 16:25:33 +0200
Message-ID: <CAHKzcEPP-qShW15z4V8cQDtHXggSKQT9sSoj2jm_fPuYxTYHnw@mail.gmail.com>
References: <20170608154707.1094-1-waldemar.rymarkiewicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38435 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751583AbdF1O0P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jun 2017 10:26:15 -0400
In-Reply-To: <20170608154707.1094-1-waldemar.rymarkiewicz@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org
Cc: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>, linux-kernel@vger.kernel.org

On 8 June 2017 at 17:47, Waldemar Rymarkiewicz
<waldemar.rymarkiewicz@gmail.com> wrote:
> Most likely copy-paste mistake, so replace __CPU_COOLING_H__ header guard
> with more suitable __CLOCK_COOLING_H__.
>
> Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
> ---
>  include/linux/clock_cooling.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)


+ linux-pm and thermal people

/Waldek
