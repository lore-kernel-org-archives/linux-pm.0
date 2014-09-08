From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: PROBLEM: Kernel OOPS and possible system freeze after concurrent
 writing to cpufreq/scaling_governor (Resend)
Date: Mon, 8 Sep 2014 18:27:20 +0530
Message-ID: <CAKohpokM3kzmG1c1pWfjKrSV+UV6nW7tXt9+8Gz-KwomzKqAXw@mail.gmail.com>
References: <1405522398.2348.42.camel@x200t>
	<1406185912.2406.3.camel@x200t>
	<CAKohpomo_Qoc-ioC-L-n6z19SLMgCfzebec7pqkq9y86gt61HA@mail.gmail.com>
	<1406277769.2399.4.camel@x200t>
	<CAKohpomDkU1nBP4+1EkSdDxQESD+1b6kmaELVfGEifqTL+ZOdg@mail.gmail.com>
	<1410164208.6159.18.camel@x200t>
	<CAKohpo=DeQQq505U_EDsJ+5dPGPuSOypx_YbTYW5owj4FDYLpA@mail.gmail.com>
	<1410179322.25768.7.camel@x200t>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:44344 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753488AbaIHM5V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Sep 2014 08:57:21 -0400
Received: by mail-oi0-f47.google.com with SMTP id a141so7727492oig.6
        for <linux-pm@vger.kernel.org>; Mon, 08 Sep 2014 05:57:20 -0700 (PDT)
In-Reply-To: <1410179322.25768.7.camel@x200t>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Robert_Sch=C3=B6ne?= <robert.schoene@tu-dresden.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Prarit Bhargava <prarit@redhat.com>, Saravana Kannan <skannan@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>

On 8 September 2014 17:58, Robert Sch=C3=B6ne <robert.schoene@tu-dresde=
n.de> wrote:
> The patch works for me.
>
> Thank you!
>
> PS: With this patch I get an EINVAL when writing fails (instead of an
> EBUSY). Is this intended?

That's because cpufreq_set_policy() returns.. We can fix it separately =
if we
really want.
