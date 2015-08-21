From: Yan Pashkovsky <yanpaso@gmail.com>
Subject: Re: API for querying the resume cause
Date: Sat, 22 Aug 2015 00:09:00 +0300
Message-ID: <55D7936C.9060208@gmail.com>
References: <55D5BE6B.5070805@gmail.com> <CAJKOXPe+ud=uCRKbQiggg7tLeShgYJbD16W_26qYo4E4-4mXrw@mail.gmail.com> <55D69852.3010902@intel.com> <9D8C9A00-9AA7-4BA1-9953-3DB1A88468D5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:36364 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbbHUVJE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Aug 2015 17:09:04 -0400
Received: by lbbpu9 with SMTP id pu9so51018223lbb.3
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2015 14:09:02 -0700 (PDT)
In-Reply-To: <9D8C9A00-9AA7-4BA1-9953-3DB1A88468D5@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yu Chen <yu.c.chen@intel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Alexandra Yates <alexandra.yates@linux.intel.com>, Bastien Nocera <hadess@hadess.net>, Aaron Lu <aaron.lu@intel.com>, Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>


I see that the community is awared of such problem. I would like to ask=
=20
how to track  status of this API implementation except of receiving ton=
s=20
of emails in this mailing list?  :) My bug report was closed.  I would=20
like to contact Lennart when it would be ready.

21.08.2015 06:17, Yu Chen =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
 > On 08/21/2015 10:07 AM, Krzysztof Kozlowski wrote:
 >> 2015-08-20 20:47 GMT+09:00 Yan Pashkovsky <yanpaso@gmail.com>:
 >>
 >> A little bit similar work from Alexandra Yates (CC-ed):
 >> Report interrupt(s) that caused system wakeup
 >> http://comments.gmane.org/gmane.linux.power-management.general/6380=
5
 >>
 > This topic is interesting : )
 > BTW, in github.com/systemd/systemd/issues/926, Lennart is worried
 > about rtcwake unstable platforms. How about using suspend-to-idle
 > on these platforms, and leverage a timer instead of rtcwake..
 >
 > Best Regards,
 > Yu
 >>
 >>
 >> Best regards,
 >> Krzysztof
 >
 >

