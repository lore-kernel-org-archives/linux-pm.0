From: Yadwinder Singh Brar <yadi.brar01@gmail.com>
Subject: Re: [RFC v2 1/4] power: asv: Add common ASV support for Samsung SoCs
Date: Sun, 15 Dec 2013 22:38:07 +0900
Message-ID: <CAKew6eVieLHyzQ38-Dm-dRh_P0e9wv+kEu5xCsBWgSq_-gQNBg@mail.gmail.com>
References: <1384515691-26299-1-git-send-email-sachin.kamat@linaro.org>
	<1384515691-26299-2-git-send-email-sachin.kamat@linaro.org>
	<CAM4voam5GS5HORbb_r57C_61cMafKjQnBnR0dxD7x-9iTBps8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:46483 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754085Ab3LONiH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 15 Dec 2013 08:38:07 -0500
In-Reply-To: <CAM4voam5GS5HORbb_r57C_61cMafKjQnBnR0dxD7x-9iTBps8Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Cc: Sachin Kamat <sachin.kamat@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, "myungjoo.ham" <myungjoo.ham@samsung.com>, Yadwinder Singh Brar <yadi.brar@samsung.com>, Andrew Bresticker <abrestic@google.com>, Doug Anderson <dianders@google.com>

Hi Abhilash,

[ ... ]
>> + * @nr_dvfs_level: Number of dvfs levels supported by member.
>> + * @dvfs_table: Table containing supported ASV freqs and corresponding volts.
>> + * @asv_grp: ASV group of member.
>> + * @flags: ASV flags
> What are the ASV flags you had in mind ?

Right now we don't have any, some thing like delayed
init of asv table depending upon dev_node/user(instance)
was coming in my mind.
Actually I missed to remove it for the time being.

Thanks for your review and other suggestions.

Regards,
Yadwinder
