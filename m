From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 0/4] nvmem: new drivers for v4.5
Date: Tue, 19 Jan 2016 10:15:45 -0800
Message-ID: <CAGS+omDHYeDCaHJC8Q3i4utTUJt40FPyq6S_maQ7scG_2oDmsQ@mail.gmail.com>
References: <1449485763-391-1-git-send-email-srinivas.kandagatla@linaro.org>
 <5693AC68.6040802@linaro.org> <20160111183018.GA10243@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:34977 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932510AbcASSQG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2016 13:16:06 -0500
Received: by mail-vk0-f54.google.com with SMTP id k1so353052779vkb.2
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2016 10:16:05 -0800 (PST)
In-Reply-To: <20160111183018.GA10243@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Andrew-CT Chen <andrew-ct.chen@mediatek.com>, ariel@vanguardiasur.com.ar, Sascha Hauer <s.hauer@pengutronix.de>, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@arm.com>, linux-pm@vger.kernel.org

Hi Greg,

On Mon, Jan 11, 2016 at 10:30 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jan 11, 2016 at 01:21:44PM +0000, Srinivas Kandagatla wrote:
> >
> >
> > On 07/12/15 10:56, Srinivas Kandagatla wrote:
> > >Hi Greg,
> > >
> > >Here are 2 new nvmem drivers which are in the mailing list for long time
> > >and are good to go for some testing and find its way to v4.5-rc*.
> > >
> > >Could you please take these patches via char-misc tree.
> > Hi Greg,
> >
> > I have not seen these patches or https://lkml.org/lkml/2015/12/14/169 appear
> > in your char-misc tree/linux-next.
> >
> > Just wanted to know whats your plan on these patches?
>
> To wait until after 4.5-rc1 is out, sorry, my patch backlog got huge
> during Nov/Dec due to other external issues, I'll be digging out from
> them after 4.5-rc1 is out.

Soon after 4.5-rc1 sounds great.

FYI, to add some context, the Mediatek nvmem driver is actually
blocking several other drivers that we would also like to see land in
v4.5:  Mediatek thermal, Mediatek cpufreq_thermal, and Mediatek
devfreq_thermal.

So, the sooner nvmem lands, the earlier we can start staging/pushing
through the rest.

Thanks,
-Dan

>
> thanks,
>
> greg k-h
