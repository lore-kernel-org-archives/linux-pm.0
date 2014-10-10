From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Fri, 10 Oct 2014 18:09:08 +0530
Message-ID: <CAKohpomvrKxnk3ZOtZxZEO+fVWSr5gB1AadtFUib8jsqndDgtg@mail.gmail.com>
References: <CAKohpo=rEYgH+PSmkP8X8J0u69Kyp1W7JzBFOiOsiCOFSdyAiw@mail.gmail.com>
	<54353223.7080704@redhat.com>
	<CAKohpok+z+bPySa+Kzh2zW+2L8CCG29q6wANe3jd+o80+PnASA@mail.gmail.com>
	<5437C12D.1070803@redhat.com>
	<CAKohpokDG1_r7eJ5Yykea4orcuEicCUFCrnSo1uTgKW1iJGwRA@mail.gmail.com>
	<5437C535.3070707@redhat.com>
	<CAKohpo=_vgxvtJYA_53jdicnRivihAVQuEgoKk7S7MhZctyZkw@mail.gmail.com>
	<5437C778.4040108@redhat.com>
	<1412942496.13463.28.camel@x200t>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:60939 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbaJJMjJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Oct 2014 08:39:09 -0400
Received: by mail-oi0-f52.google.com with SMTP id a3so6362120oib.11
        for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2014 05:39:08 -0700 (PDT)
In-Reply-To: <1412942496.13463.28.camel@x200t>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Robert_Sch=C3=B6ne?= <robert.schoene@tu-dresden.de>
Cc: Prarit Bhargava <prarit@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>

On 10 October 2014 17:31, Robert Sch=C3=B6ne <robert.schoene@tu-dresden=
=2Ede> wrote:
> In v2 my system still crashes when concurrently setting the governors
> I wasn't able to get a stack trace.

Are you sure its the same crash log or some other bug has got in ?
It would be helpful to have a .jpg of crash even.
