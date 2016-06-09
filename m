From: =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k+lkml@gmail.com>
Subject: Re: [PATCH] power/reset: make syscon_poweroff() static
Date: Thu, 9 Jun 2016 12:24:49 +0200
Message-ID: <CAJKOXPebLFfDyrDP0nMGdVkVqhbDs-jT9g8-FQ4FwW_0CqxywA@mail.gmail.com>
References: <1465410534-29694-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35654 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbcFIKYv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2016 06:24:51 -0400
Received: by mail-oi0-f66.google.com with SMTP id k63so6553418oib.2
        for <linux-pm@vger.kernel.org>; Thu, 09 Jun 2016 03:24:50 -0700 (PDT)
In-Reply-To: <1465410534-29694-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org

On Wed, Jun 8, 2016 at 8:28 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> The syscon_poweroff() function is not exported or declared for
> usage elsewhere, so make it static to avoid the folloiwing warning:
>
> drivers/power/reset/syscon-poweroff.c:33:6: warning: symbol 'syscon_poweroff' was not declared. Should it be static?
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: linux-pm@vger.kernel.org
> ---
>  drivers/power/reset/syscon-poweroff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
