From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v2 00/17] thermal: exynos: Thermal code rework to use
 device tree
Date: Mon, 22 Dec 2014 17:21:33 +0100
Message-ID: <20141222172133.6e69fc21@amdc2363>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1418213396-743-1-git-send-email-l.majewski@samsung.com>
 <20141210102712.GA2919@developer> <20141210151925.61a0b091@amdc2363>
 <CAM4voakxJPjfGu3gkpCbDS+SY1TP39Of+0ed=5jS55ARn95pYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:29549 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754588AbaLVQVm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Dec 2014 11:21:42 -0500
In-reply-to: <CAM4voakxJPjfGu3gkpCbDS+SY1TP39Of+0ed=5jS55ARn95pYg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Abhilash Kesavan <kesavan.abhilash@gmail.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>

Hi Abhilash,

> Hi Lukasz and Eduardo,
> 
> [...]
> >
> > Although, this shouldn't be a problem.
> >
> >> That is why we had the cycle with cpufreq folks, remember?
> >>
> >> (I will have a look in your patches)
> >
> > It would be great if those patches could find their way to therma
> > -next. Then also Abhilash could benefit from them.
> 
> I have a couple of 5420/5800 based chromebooks that I will test this
> series on. Is it OK for me to start basing my Exynos7 TMU support on
> this series ? Please let me know if I can help in any other way with
> this.

I'm fine if you rebase on top of my patches. 

However, it is up to Eduardo when he decides to pull them to -next
branch.

I hope that it will happen soon.

> 
> Regards,
> Abhilash



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
