From: Mascha Kurpicz <mascha.kurpicz@unine.ch>
Subject: Re: time_in_state on Ubuntu 13.10
Date: Mon, 5 May 2014 14:08:09 +0200
Message-ID: <53677F29.2090905@unine.ch>
References: <535E6906.2090201@unine.ch>	<CAOh2x==Q_oDn9v4S5ggh_e-3_=vSU_5Ko_89LfWM9ARBS9i=Rg@mail.gmail.com>	<535F51F7.5090804@unine.ch>	<CAKohponpGMMRUvDivaxj_qz5dQvhxZHiHW4Z19GzpaEJHGStRQ@mail.gmail.com>	<535F6508.5020202@unine.ch> <CAKohponNhk2wxM2vTX6ZWf590bxTSjT-53oV9D6AKPch+VbsSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from columba.unine.ch ([130.125.1.53]:41741 "EHLO unine.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756486AbaEEMIN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 5 May 2014 08:08:13 -0400
In-Reply-To: <CAKohponNhk2wxM2vTX6ZWf590bxTSjT-53oV9D6AKPch+VbsSw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Maxime Colmant <maxime.colmant@inria.fr>

On 05/02/2014 07:25 AM, Viresh Kumar wrote:
> On 29 April 2014 14:08, Mascha Kurpicz <mascha.kurpicz@unine.ch> wrote:
>> On 04/29/2014 10:26 AM, Viresh Kumar wrote:
>>> On 29 April 2014 12:47, Mascha Kurpicz <mascha.kurpicz@unine.ch> wrote:
>>>> Sorry for the imprecision.
>>>>
>>>> Works correctly with
>>>> Ubuntu 12.04.3 LTS - kernel 3.2.0-29-generic
>>>> Ubuntu 12.04.3 LTS -  kernel 3.8.0-29
>>>> Ubuntu 13.10 - kernel 3.8.0-29-generic
>>>>
>>>> 0 or very small (e.g. 6) values with
>>>> Ubuntu 13.10 - kernel 3.11.0-20-generic
>>> Can you provide cpufreq-info 's output for the last two cases please?
> Sorry, got distracted and just forgot about this thread :), must have marked
> it in my pending list :(
>
> Anyways, I have tried to look at the diff between these kernel releases and
> looks like I couldn't figure out what's going wrong.
>
> I tried to test things with the latest kernel and they seem to be working fine.
> Atleast on my ARM board.
>
> Would it be possible for you to do a git bisect between 3.8 and 3.11 ?
We just tested with the latest release (14.04) and realized that the
issue was already fixed for the latest kernel version, sorry about that!

https://lkml.org/lkml/2013/9/7/119

Thanks anyways for your support :-)

> --
> viresh

