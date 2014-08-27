From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH 1/2] arm: irq: Notify affinity change when migrating IRQs
 during hotplug
Date: Wed, 27 Aug 2014 16:51:39 -0600
Message-ID: <20140827225139.GD79706@ilina-mac.domain>
References: <1408553988-63924-1-git-send-email-lina.iyer@linaro.org>
 <7hegw1g8qx.fsf@paris.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:39787 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932603AbaH0Wvr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Aug 2014 18:51:47 -0400
Received: by mail-pa0-f49.google.com with SMTP id kq14so67233pab.22
        for <linux-pm@vger.kernel.org>; Wed, 27 Aug 2014 15:51:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7hegw1g8qx.fsf@paris.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: tglx@linutronix.de, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, ulf.hansson@linaro.org, Praveen Chidambaram <pchidamb@codeaurora.org>

On Wed, Aug 27, 2014 at 10:09:10AM -0700, Kevin Hilman wrote:
>Lina Iyer <lina.iyer@linaro.org> writes:
>
>> From: Praveen Chidambaram <pchidamb@codeaurora.org>
>>
>> Hotplug causes IRQs affine to a core that is being taken down to migrate
>> to an online core. This is done by directly calling the irq_set_affinity
>> associated with the irq_chip structure. Instead using the
>> irq_set_affinity_locked() api lets the notifications bubble through.
>
>changelog nit: and why do you want/need the notification to bubble
>through?   IOW, you're explaining "what" the patch does, but not "why",
>which typically includes a summary of the problem being solved.  (I know
>the background from the other series, but other reviewers may not know
>the history there.)
Okay. I seem to be making the mistake of not explaining things very
well, in context.
Let me elaborate and resend.
>
>Also, please post these to linux-arm-kernel.
>
>Thanks,
>
>Kevin
