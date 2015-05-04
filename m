From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/4] sched / idle: Move the default idle call code to
 a separate function
Date: Mon, 04 May 2015 16:00:16 +0200
Message-ID: <55477B70.6020207@linaro.org>
References: <3084951.QaIkFrZ3VU@vostro.rjw.lan> <1607938.mB5HZupMYV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34535 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbbEDOAU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2015 10:00:20 -0400
Received: by wicmx19 with SMTP id mx19so78125510wic.1
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2015 07:00:19 -0700 (PDT)
In-Reply-To: <1607938.mB5HZupMYV@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 05/04/2015 03:56 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Move the code under the "use_default" label in cpuidle_idle_call()
> into a separate (new) function.
>
> This just allows the subsequent changes to be more stratightforward.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

