From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: Q: cpuidle results in degredation in ethernet performance ?
Date: Tue, 04 Aug 2015 16:28:39 +0200
Message-ID: <55C0CC17.604@linaro.org>
References: <CAJ2oMhKw0gpFMKOd-iYe_hYh56Q62XgpW+MJmyiGhdkGn1RTMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33219 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756382AbbHDO2m (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2015 10:28:42 -0400
Received: by wijp15 with SMTP id p15so8617547wij.0
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2015 07:28:41 -0700 (PDT)
In-Reply-To: <CAJ2oMhKw0gpFMKOd-iYe_hYh56Q62XgpW+MJmyiGhdkGn1RTMg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ran Shalit <ranshalit@gmail.com>, linux-pm@vger.kernel.org

On 08/01/2015 09:34 PM, Ran Shalit wrote:
> Hello,
>
> Maybe if someone here understands cpuidel he can help me...
>
> I am using omap, with cpuidel and I have some strange behaviour only
> when cpuidle is used:
> 1.  I test ethernet bandwidth with iperf
> 2. With large packet test (16k), I get same bandwidth in version with
> cpuidle support as in version without cpuidel supported.
> 3. With small packet test (<2000 bytes), I get high degredation in
> performance in version with cpuidle. On viewing statistics I see that
> the cpu gets into cpu inactive state (C3 state -  not retention yet,
> only cpu not active). I guess this is the cuase of the degredation.
> With large packets I get no increment in C3 state usage.
> 4. I think that menu governer behaviour might explain this, but I
> don't understand it deeply enough.
>
> Can anyone shed a light on this ? Is there anything I can do to overc=
ome this ?

Is an omap3 or omap4 ?



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

