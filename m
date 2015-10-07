From: Bjorn Andersson <bjorn@kryo.se>
Subject: Re: [Device-mainlining] [PATCH v4 1/5] gadget: Introduce the notifier functions
Date: Wed, 7 Oct 2015 09:44:38 -0700
Message-ID: <CAJAp7Oj-O+s7V1KjpFm-UWOP6ecCWoBzXZnHhLuC8E3_Wu3ksg@mail.gmail.com>
References: <cover.1443057229.git.baolin.wang@linaro.org>
	<e58e4f26028c37877d02907831cf4ae411eaf984.1443057231.git.baolin.wang@linaro.org>
	<20151001172932.GG4469@saruman.tx.rr.com>
	<20151001174308.GL12635@sirena.org.uk>
	<20151001175849.GH4469@saruman.tx.rr.com>
	<20151002164743.GR12635@sirena.org.uk>
	<20151002172311.GI5552@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:35423 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754296AbbJGQoj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2015 12:44:39 -0400
Received: by lbwr8 with SMTP id r8so17961340lbw.2
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2015 09:44:38 -0700 (PDT)
In-Reply-To: <20151002172311.GI5552@saruman.tx.rr.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Mark Brown <broonie@kernel.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Baolin Wang <baolin.wang@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, r.baldyga@samsung.com, Sebastian Reichel <sre@kernel.org>, sojka@merica.cz, stern@rowland.harvard.edu, peter.chen@freescale.com, linux-pm@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, Lee Jones <lee.jones@linaro.org>, David Woodhouse <dwmw2@infradead.org>, ckeepax@opensource.wolfsonmicro.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Oct 2, 2015 at 10:23 AM, Felipe Balbi via device-mainlining
<device-mainlining@lists.linuxfoundation.org> wrote:
[..]
> The real difficulty here is coming up with an interface which we're agreeing to
> supporting for the next 30 years. Whatever that is, as soon as it gets exposed
> to userland, we will have to support it.
>

Isn't this the main reason for not creating a user space ABI now?

Running with the in-kernel hooks would allow us to get things working
now, we can change it as we wish, we can explore the difficulties and
we can create an ABI from that - if we need to - that might have a
chance to work for the next 30 years.

Regards,
Bjorn
