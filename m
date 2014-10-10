From: Robert =?ISO-8859-1?Q?Sch=F6ne?= <robert.schoene@tu-dresden.de>
Subject: Re: [PATCH 1/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Fri, 10 Oct 2014 15:04:29 +0200
Message-ID: <1412946269.13463.33.camel@x200t>
References: <CAKohpo=rEYgH+PSmkP8X8J0u69Kyp1W7JzBFOiOsiCOFSdyAiw@mail.gmail.com>
	 <54353223.7080704@redhat.com>
	 <CAKohpok+z+bPySa+Kzh2zW+2L8CCG29q6wANe3jd+o80+PnASA@mail.gmail.com>
	 <5437C12D.1070803@redhat.com>
	 <CAKohpokDG1_r7eJ5Yykea4orcuEicCUFCrnSo1uTgKW1iJGwRA@mail.gmail.com>
	 <5437C535.3070707@redhat.com>
	 <CAKohpo=_vgxvtJYA_53jdicnRivihAVQuEgoKk7S7MhZctyZkw@mail.gmail.com>
	 <5437C778.4040108@redhat.com> <1412942496.13463.28.camel@x200t>
	 <CAKohpomvrKxnk3ZOtZxZEO+fVWSr5gB1AadtFUib8jsqndDgtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-7"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.zih.tu-dresden.de ([141.30.67.73]:33878 "EHLO
	mailout2.zih.tu-dresden.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751853AbaJJNEk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Oct 2014 09:04:40 -0400
In-Reply-To: <CAKohpomvrKxnk3ZOtZxZEO+fVWSr5gB1AadtFUib8jsqndDgtg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Prarit Bhargava <prarit@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>

The crash results in a lot of output. My Remote-Keyboard-Video-Mouse
equipment is not fast enough to gather this output, as I get numerous
follow-up errors at a regular base. However, you can get the same error,
if you run my test script on a multi core system.

Robert

Am Freitag, den 10.10.2014, 18:09 +-0530 schrieb Viresh Kumar:
+AD4 On 10 October 2014 17:31, Robert Sch+APY-ne +ADw-robert.schoene+AEA-tu-dresden.de+AD4 wrote:
+AD4 +AD4 In v2 my system still crashes when concurrently setting the governors
+AD4 +AD4 I wasn't able to get a stack trace.
+AD4 
+AD4 Are you sure its the same crash log or some other bug has got in ?
+AD4 It would be helpful to have a .jpg of crash even.


