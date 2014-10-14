From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Tue, 14 Oct 2014 12:28:07 +0530
Message-ID: <CAKohpokBzXG=zSicg5uMGK7=qTCOObG_r4Z4trkRmQxftv0vyw@mail.gmail.com>
References: <CAKohpo=rEYgH+PSmkP8X8J0u69Kyp1W7JzBFOiOsiCOFSdyAiw@mail.gmail.com>
	<54353223.7080704@redhat.com>
	<CAKohpok+z+bPySa+Kzh2zW+2L8CCG29q6wANe3jd+o80+PnASA@mail.gmail.com>
	<5437C12D.1070803@redhat.com>
	<CAKohpokDG1_r7eJ5Yykea4orcuEicCUFCrnSo1uTgKW1iJGwRA@mail.gmail.com>
	<5437C535.3070707@redhat.com>
	<CAKohpo=_vgxvtJYA_53jdicnRivihAVQuEgoKk7S7MhZctyZkw@mail.gmail.com>
	<5437C778.4040108@redhat.com>
	<1412942496.13463.28.camel@x200t>
	<CAKohpomvrKxnk3ZOtZxZEO+fVWSr5gB1AadtFUib8jsqndDgtg@mail.gmail.com>
	<1412947425.13463.37.camel@x200t>
	<CAKohpokag-ppE7WH=jPS6-i_T-5PyaDKyKS8uC+Xt2QGxLHYkw@mail.gmail.com>
	<1412949926.13463.47.camel@x200t>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:43180 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbaJNG6H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Oct 2014 02:58:07 -0400
Received: by mail-oi0-f45.google.com with SMTP id i138so15732012oig.32
        for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2014 23:58:07 -0700 (PDT)
In-Reply-To: <1412949926.13463.47.camel@x200t>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Robert_Sch=C3=B6ne?= <robert.schoene@tu-dresden.de>, Prarit Bhargava <prarit@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>

On 10 October 2014 19:35, Robert Sch=C3=B6ne <robert.schoene@tu-dresden=
=2Ede> wrote:
> @all:
> I have to leave now and will not be available for a week.
>
> @Viresh:
> The line you are looking for is 2c8 (260h+68h, length check passed).
> Here it is with the surrounding instructions:

Thanks..

I now understand most of the races you and Prarit have reported.
=46inally I was able to get my multi-cluster board up and could test th=
is
myself :)

So you need to try my cpufreq/governor-fixes-v4 branch to confirm if
this fixes your issues or not.

@Prarit: As Robert probably isn't around this week, would it be possibl=
e for
you to test this stuff ?

I will send this as a patchset so that people can review and comment.

--
viresh
