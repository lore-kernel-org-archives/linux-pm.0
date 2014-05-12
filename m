From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] PM / suspend: Always use deepest C-state in the "freeze"
 sleep state
Date: Mon, 12 May 2014 16:08:36 +0200
Message-ID: <5370D5E4.5040001@linaro.org>
References: <2548502.zJ1no3NhRc@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:36091 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756705AbaELOI3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 May 2014 10:08:29 -0400
Received: by mail-wg0-f47.google.com with SMTP id x12so6955047wgg.30
        for <linux-pm@vger.kernel.org>; Mon, 12 May 2014 07:08:28 -0700 (PDT)
In-Reply-To: <2548502.zJ1no3NhRc@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Aubrey Li <aubrey.li@intel.com>

On 05/05/2014 12:51 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> If freeze_enter() is called, we want to bypass the current cpuidle
> governor and always use the deepest available (that is, not disabled)
> C-state, because we want to save as much energy as reasonably possibl=
e
> then and runtime latency constraints don't matter at that point, sinc=
e
> the system is in a sleep state anyway.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> This is on top of https://patchwork.kernel.org/patch/4071541/ .
>

Wouldn't make sense to revisit play_dead instead ?



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

