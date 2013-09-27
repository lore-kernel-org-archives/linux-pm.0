From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/6] cpuidle: calxeda: add support to use PSCI calls
Date: Fri, 27 Sep 2013 10:44:19 +0200
Message-ID: <52454563.9000208@linaro.org>
References: <1380248694-13388-1-git-send-email-robherring2@gmail.com> <1380248694-13388-2-git-send-email-robherring2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:33374 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206Ab3I0IoW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Sep 2013 04:44:22 -0400
Received: by mail-wg0-f51.google.com with SMTP id c11so2380138wgh.30
        for <linux-pm@vger.kernel.org>; Fri, 27 Sep 2013 01:44:21 -0700 (PDT)
In-Reply-To: <1380248694-13388-2-git-send-email-robherring2@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <rob.herring@calxeda.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org

On 09/27/2013 04:24 AM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> This updates the Calxeda cpuidle driver to use PSCI calls to powergat=
e
> cores. This is needed to enable cpuidle for the ECX-2000.
>
> This could possibly become a generic PSCI driver, but there are no ot=
her
> PSCI users in the kernel other than mach-virt.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm@vger.kernel.org

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

