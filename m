From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Wed, 8 Oct 2014 12:34:52 +0530
Message-ID: <CAKohpo=rEYgH+PSmkP8X8J0u69Kyp1W7JzBFOiOsiCOFSdyAiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:48752 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbaJHHEw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Oct 2014 03:04:52 -0400
Received: by mail-oi0-f50.google.com with SMTP id i138so6558865oig.37
        for <linux-pm@vger.kernel.org>; Wed, 08 Oct 2014 00:04:52 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Robert_Sch=C3=B6ne?= <robert.schoene@tu-dresden.de>, Prarit Bhargava <prarit@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>

On 25 September 2014 11:37, Robert Sch=C3=B6ne <robert.schoene@tu-dresd=
en.de> wrote:
> We had some iterations of patches, but the only solution that works f=
or
> me is the patch with the coarse-grained lock that I sent at Mon, 08 S=
ep
> 2014 10:16:48 CEST [1]
> Viresh is pretty occupied lately, but he told me that he might do the
> tests himself when the current period of busyness is over as he is
> supplied with a test system. I'm not sure about his current status (b=
usy
> or testing).

Hi Robert/Prarit,

The last state of my branch: cpufreq/governor-fixes you tested had
few bugs in it and so you weren't able to even tests things up.

I couldn't manage to test my patches on a multi-cluster system
(couldn't get it up yet :( ), but was able to do that on a dual-core
ARM-cortexA15 board. And could simply find the bugs there.

I have updated my branch with the changes now and it would be
great if you can confirm if they fix your issues or not.

git://git.linaro.org/people/viresh.kumar/linux.git cpufreq/governor-fix=
es

--
viresh
