From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: backup/restore concept?
Date: Wed, 24 Jul 2013 11:19:49 +0530
Message-ID: <CAKohpo=i6xcUEXzkcJ9onHDc+O_TvKB1m_mwobuVbxF=BCwazg@mail.gmail.com>
References: <CANMsd01y=eeQ356m=82PrdfZ0q50MpE53DoeQS6sDT=HaaZFzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:35566 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab3GXFtu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2013 01:49:50 -0400
Received: by mail-ob0-f178.google.com with SMTP id fb19so12288559obc.9
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2013 22:49:49 -0700 (PDT)
In-Reply-To: <CANMsd01y=eeQ356m=82PrdfZ0q50MpE53DoeQS6sDT=HaaZFzw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ryan <ryanphilips19@googlemail.com>
Cc: Lists linaro-dev <linaro-dev@lists.linaro.org>, linux-pm@vger.kernel.org

Adding more relevant list in cc.

On 23 July 2013 16:05, Ryan <ryanphilips19@googlemail.com> wrote:
> Hi,
>
> I have some doubts on backup and restore operation. From what i understand:
>
> We copy all registers values & addresses of all controllers in the SOC
> to the internal RAM or SRAM.
> before we put CPU to sleep?
>
> I want to know if we also copy the code segment into SRAM and what
> happens after wakeup.
> If so, where exactly we need to copy and how cpu jumps here after
> wakeup. or is there any other mechanism
> that is used. What executes first since DDR is in self-refresh.
>
> I use OMAP4 and this is my understanding. I could not understand much
> other than in OFF mode
> all the controller registers get copied to SRAM. Does anything else
> also gets copied too?
> or am i missing any basics here.
>
>
>
> Can anyone clarify my understanding.
>
> /Ryan
>
> _______________________________________________
> linaro-dev mailing list
> linaro-dev@lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-dev
