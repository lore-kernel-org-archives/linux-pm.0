From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: PROBLEM: cpuidle: Quickly notice prediction failure for repeat
 mode
Date: Thu, 19 Dec 2013 21:11:15 +0100
Message-ID: <52B352E3.1040903@linaro.org>
References: <20131219195159.GB16912@holos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:58454 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756211Ab3LSULN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2013 15:11:13 -0500
Received: by mail-we0-f178.google.com with SMTP id u57so1610413wes.9
        for <linux-pm@vger.kernel.org>; Thu, 19 Dec 2013 12:11:13 -0800 (PST)
In-Reply-To: <20131219195159.GB16912@holos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Oteiza <mvoteiza@udel.edu>, linux-pm@vger.kernel.org

On 12/19/2013 08:51 PM, Mark Oteiza wrote:
> Hi,
>
> Commit 1485191 causes a regression on my hardware (laptop) manifestin=
g
> itself as increased power consumption when playing music on mpd using
> pulseaudio.
>
> I bisected to find 1485191.  I tested the commit it reverts (69a37bea=
),
> and the commit prior 69a37bea, e34a00d6.  Here's a summary:
>
>    status      sha   power  coretemp
>    ---------------------------------
>    BAD    14851912     14W       54C
>    GOOD   228b3023      9W       47C
>    GOOD   69a37bea   ~8.8W       47C
>    GOOD   e45a00d6   ~9.3W       47C

Hi Mark,

thanks for the measurements.

Is it possible you do some perf benchmarking. IIRC, this patch was=20
reverted because it introduced some perf regression.

   -- Daniel

>
> I thought it was strange that it happens only with that combination o=
f
> audio software, so I was happy to patch out that changeset which was =
bad
> for me.  Past 3.12 (now on 3.12.5), the issue persists and I'm not su=
re
> I can easily merge anymore.
>
> I attached some info I hope will be helpful.
>
> Thanks,
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

