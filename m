From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] PM / suspend: Always use deepest C-state in the "freeze"
 sleep state
Date: Mon, 12 May 2014 16:52:22 +0200
Message-ID: <5370E026.5040105@linaro.org>
References: <2548502.zJ1no3NhRc@vostro.rjw.lan> <5370D5E4.5040001@linaro.org> <5370D85C.3090505@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:64599 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758432AbaELOwO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 May 2014 10:52:14 -0400
Received: by mail-wg0-f50.google.com with SMTP id x12so7096942wgg.9
        for <linux-pm@vger.kernel.org>; Mon, 12 May 2014 07:52:13 -0700 (PDT)
In-Reply-To: <5370D85C.3090505@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Li, Aubrey" <aubrey.li@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Aubrey Li <aubrey.li@intel.com>

On 05/12/2014 04:19 PM, Li, Aubrey wrote:
> On 2014/5/12 22:08, Daniel Lezcano wrote:
>> On 05/05/2014 12:51 AM, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> If freeze_enter() is called, we want to bypass the current cpuidle
>>> governor and always use the deepest available (that is, not disable=
d)
>>> C-state, because we want to save as much energy as reasonably possi=
ble
>>> then and runtime latency constraints don't matter at that point, si=
nce
>>> the system is in a sleep state anyway.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>
>>> This is on top of https://patchwork.kernel.org/patch/4071541/ .
>>>
>>
>> Wouldn't make sense to revisit play_dead instead ?
>>
> play_dead() is broken.
>
> Even if it works, we still should rely on cpuidle driver to place the
> CPUs into the deepest c-state, because there is no architectural way =
to
> enter deepest c-state and what play_dead() does is a bad assumption.

Ok, let me rephrase it. Why not revisiting cpuidle_play_dead instead ?


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

