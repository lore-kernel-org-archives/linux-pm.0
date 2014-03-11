From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: add 'failed' statistic
Date: Tue, 11 Mar 2014 22:52:44 +0100
Message-ID: <531F85AC.3000404@linaro.org>
References: <1394165650-6927-1-git-send-email-daniel.lezcano@linaro.org> <CAJvTdKmUKS82YxkQio2_bPqXv7kNnyFpHcuvfZ=ExBZrkEg1eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:59029 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081AbaCKVwo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Mar 2014 17:52:44 -0400
Received: by mail-pa0-f45.google.com with SMTP id kl14so145786pab.4
        for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2014 14:52:44 -0700 (PDT)
In-Reply-To: <CAJvTdKmUKS82YxkQio2_bPqXv7kNnyFpHcuvfZ=ExBZrkEg1eA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 03/11/2014 03:00 AM, Len Brown wrote:
> Exactly what use-case do you have in mind for this attribute?

Nothing more than balance the c-state usage with the selection=20
efficiency of this state. The current statistics do not give a lot of=20
clues of what is happening.

> "failed" is a strong word.
> Some validation guy is going to send me e-mail when it is non-zero...
> I don't like that use-case.
>
> But even if re-named, I don't see see how it will be useful.
> When I want to see how C-state predictions are doing, I use ftrace,
> which can show me the actual expected and actual times, not just a co=
unt
> of how man times predicted was < actual.

Mmh, where do you retrieve the target_residency from userspace ? This=20
information is not exported from ftrace neither sysfs.

> I would rather see some good tracepoints go upstream.

Ok, which tracepoints you would like to see ?

target residency=3D%lu, expected residency=3D%lu, measured residency=3D=
%lu

??

Thanks
   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

