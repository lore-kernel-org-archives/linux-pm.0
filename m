From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: Make OPP invisible to users in Kconfig
Date: Mon, 12 May 2014 09:40:46 +0530
Message-ID: <CAKohpo=xtnHyWcjHxmSPgzdovMshgotMkQj6Y__R9UvzzfTyHw@mail.gmail.com>
References: <1399659488-13974-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:47083 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbaELEKr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 May 2014 00:10:47 -0400
Received: by mail-ob0-f177.google.com with SMTP id gq1so7269737obb.22
        for <linux-pm@vger.kernel.org>; Sun, 11 May 2014 21:10:47 -0700 (PDT)
In-Reply-To: <1399659488-13974-1-git-send-email-broonie@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nishanth Menon <menon.nishanth@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Mark Brown <broonie@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 9 May 2014 23:48, Mark Brown <broonie@kernel.org> wrote:
> From: Mark Brown <broonie@linaro.org>
>
> The OPP code is an in kernel library selected by its users, there is no
> no architecture code required to implement it and enabling it without a

s/no no/no

> user just increases the kernel size. Since the users select rather than
> depend on it just remove the ability to directly set the option from
> Kconfig.
>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>
> This leaves the ARCH_HAS_OPP symbol since removing that requires
> updating the relevant architectures, if this is OK I can sumbit a
> followup patch cleaning that up.
>
>  kernel/power/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
