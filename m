From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/2] time : pass broadcast device parameter
Date: Tue, 26 Feb 2013 12:31:44 +0100
Message-ID: <512C9D20.8020309@linaro.org>
References: <5123C299.3080005@linaro.org> <1361484083-5906-1-git-send-email-daniel.lezcano@linaro.org> <CAKohpomqooF6DzzzdUFByA0wDxQ3RuPne15a9Vy1sScKjZfeyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:54428 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754090Ab3BZLbo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Feb 2013 06:31:44 -0500
Received: by mail-ee0-f41.google.com with SMTP id c13so2272984eek.28
        for <linux-pm@vger.kernel.org>; Tue, 26 Feb 2013 03:31:43 -0800 (PST)
In-Reply-To: <CAKohpomqooF6DzzzdUFByA0wDxQ3RuPne15a9Vy1sScKjZfeyA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, fweisbec@gmail.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On 02/26/2013 09:45 AM, Viresh Kumar wrote:
> On 22 February 2013 03:31, Daniel Lezcano <daniel.lezcano@linaro.org>=
 wrote:
>> The broadcast timer could be passed as parameter to the function
>> instead of using again tick_broadcast_device.evtdev which was
>> previously used in the caller function.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>=20
> I know you are going for another round with this patchset and was jus=
t
> trying v1.
>=20
> I did my tests on ARM Vexpress - TC2, big.LITTLE Arch.
>=20
> Tested-by: Viresh Kumar <viresh.kumar@linaro.org>

Oh, by the way, could send me the patch to set the flag to the timer
device ? I will include it to the patchset.

Thanks
  -- Daniel

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

