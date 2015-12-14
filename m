From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 0/3] cpuidle: avoid module usage in non-modular code
Date: Mon, 14 Dec 2015 22:17:55 +0100
Message-ID: <566F3203.5010009@linaro.org>
References: <1450051032-32329-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:33483 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585AbbLNVRy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2015 16:17:54 -0500
Received: by mail-wm0-f47.google.com with SMTP id n186so66295583wmn.0
        for <linux-pm@vger.kernel.org>; Mon, 14 Dec 2015 13:17:53 -0800 (PST)
In-Reply-To: <1450051032-32329-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel@vger.kernel.org
Cc: Alexander Shiyan <shc_work@mail.ru>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org

On 12/14/2015 12:57 AM, Paul Gortmaker wrote:
> This series of commits is a part of a larger project to ensure
> people don't reference modular support functions in non-modular
> code.  Overall there was roughly 5k lines of dead code in the
> kernel due to this.  So far we've fixed several areas, like tty,
> x86, net, ... and we continue to work on other areas.
>
> There are several reasons to not use module support for code that
> can never be built as a module, but the big ones are:
>
>   (1) it is easy to accidentally code up unused module_exit and remov=
e code
>   (2) it can be misleading when reading the source, thinking it can b=
e
>        modular when the Makefile and/or Kconfig prohibit it
>   (3) it requires the include of the module.h header file which in tu=
rn
>       includes nearly everything else.
>
> Fortunately for cpuidle, the changes are largely trivial and change
> zero runtime.  All the changes here just remap the modular functions
> onto the non-modular ones that they would be remapped onto anyway.
>
> Changes are against linux-next and compile tested on ARM allmodconfig=
=2E
> I've Cc'd ARM list because all of these are used on ARM, but I'm
> thinking these probably can go in via the PM tree.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

