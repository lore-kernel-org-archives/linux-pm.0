From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 21/21] cpuidle: change governor from within cpuidle_replace_governor()
Date: Thu, 03 Oct 2013 13:58:17 +0200
Message-ID: <524D5BD9.6040807@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org>	<5b758e21eeb97f5f68191819c0820673692b6b75.1379779777.git.viresh.kumar@linaro.org>	<524368CF.4030803@linaro.org>	<CAKohpom_BTYC4DZLP93VzFqfnCudPb9whugPigh-jO0MpHurtw@mail.gmail.com>	<5243EE3B.1050600@linaro.org> <CAKohpomiJtmpnudWQekc8A6kPPkVNVJw3fFHFiM_6fMiwkupcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ea0-f176.google.com ([209.85.215.176]:33442 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299Ab3JCL6T (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2013 07:58:19 -0400
Received: by mail-ea0-f176.google.com with SMTP id q16so1042065ead.35
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2013 04:58:17 -0700 (PDT)
In-Reply-To: <CAKohpomiJtmpnudWQekc8A6kPPkVNVJw3fFHFiM_6fMiwkupcw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 10/03/2013 12:36 PM, Viresh Kumar wrote:
> On 26 September 2013 13:50, Daniel Lezcano <daniel.lezcano@linaro.org=
> wrote:
>> Rafael is pretty busy ATM but may be he can give his feedback on thi=
s later.
>
> For now I will resend it and maybe later you can get it cleaned up ev=
en more..
> Or maybe I will do it once I have better hold on cpuidle core :)
>
> Can I have your Ack for now? (As discussed on IRC) :)

Actually the functions cpuidle_unregister_governor and=20
cpuidle_replace_governor are dead code since the governors are no longe=
r=20
modules (commit 137b944e100278d696826cf25c83014ac17473fe), so you can=20
remove the code instead.


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

