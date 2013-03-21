From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle : handle clockevent notify from the cpuidle framework
Date: Thu, 21 Mar 2013 11:37:58 +0100
Message-ID: <514AE306.4070107@linaro.org>
References: <1363795033-26445-1-git-send-email-daniel.lezcano@linaro.org> <alpine.LFD.2.02.1303202210090.22263@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:51384 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754519Ab3CUKiB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Mar 2013 06:38:01 -0400
Received: by mail-bk0-f43.google.com with SMTP id jm19so1323224bkc.2
        for <linux-pm@vger.kernel.org>; Thu, 21 Mar 2013 03:38:00 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1303202210090.22263@ionos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, lenb@kernel.org, patches@linaro.org, linux-pm@vger.kernel.org

On 03/20/2013 10:21 PM, Thomas Gleixner wrote:
> On Wed, 20 Mar 2013, Daniel Lezcano wrote:
>=20
>> When a cpu enters a deep idle state, the local timers are stopped an=
d
>> the time framework falls back to the timer device used as a broadcas=
t
>> timer.
>>
>> The different cpuidle drivers are calling clockevents_notify ENTER/E=
XIT
>> when the idle state stops the local timer.
>>
>> The proposed patch introduces a new flag CPUIDLE_FLAG_TIMER_STOP to =
let
>=20
> Please stop using "proposed patch ...." wording in a patch
> description. The changelog you submit with your patch should be
> applicable w/o rewriting.

Oh, yes. Thanks for pointing this.

>> the cpuidle framework to call clockevents_notify instead of duplicat=
ing
>> again and again these lines in all the cpuidle drivers.
>=20
> That's a good enough reason, really. So that paragraph should be
> something like:
>=20
> "Add a new flag CPUIDLE_FLAG_TIMER_STOP which can be set by cpuidle
>  drivers. If the flag is set the cpuidle core code takes care of the
>  notification on behalf of the driver to avoid pointless code
>  duplication."
>=20
> Ideally you would follow up with two or three drivers converted to
> that new infrastructure instead of sending that patch standalone. Tha=
t
> way reviewers can really see the benefit in terms of reduced code
> duplication.

Thanks for your review. I will resend this patch with a better log and =
a
couple of patches on top using this flag.

 -- Daniel

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

