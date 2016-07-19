From: Michal Feix <michal@feix.cz>
Subject: Re: Kernel stability on baytrail machines
Date: Tue, 19 Jul 2016 06:51:17 +0200
Message-ID: <7f521bff-0fbf-a2f4-e779-c9bc40c7cd84@feix.cz>
References: <606d9b223f3c12775d108b98c4df72ae@feix.cz>
 <20160409160119.GA19362@xo-6d-61-c0.localdomain>
 <20160409201417.4436d4bd@lxorguk.ukuu.org.uk> <20160712194158.GA4834@laptop>
 <20160712212448.GA19237@amd> <864e7ac7-8041-9a81-819c-d6b60b59dd0f@feix.cz>
 <20160713104802.GA18296@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp-out3.iol.cz ([194.228.2.91]:51394 "EHLO smtp-out3.iol.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751953AbcGSEv1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 19 Jul 2016 00:51:27 -0400
In-Reply-To: <20160713104802.GA18296@atrey.karlin.mff.cuni.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org

Dne 13.7.2016 v 12:48 Pavel Machek napsal(a)

>>>> Are there any updates on the status of this issue?
>>>>
>>>> The current bugzilla report [1] marks this as a power management
>>>> issue. However, many reports indicate that it would only freeze
>>>> when running X, so it's not completely clear if it's related to
>>>> the gfx driver too.
>>> Does
>>>
>>> "intel_idle.max_cstate=1"
>>>
>>> fix it for you?
>> Yes, it does.
>>> If you feel it is X-only problem, you may want to provide details
>>> about your graphics subsystem (DRM enabled? framebuffer only?) and
>>> probably cc.
>> It's not X-only problem. Happens even in console mode, which is KMS
>> switched during boot though.
>>> ...actually... you may want to verify if it happens in unaccelerated X.
>> As it happens even in console mode, is this relevant test?
> No, no need to test with X.
>
> Would it be possible to test in good old VGA mode?
For past few days I updated to 4.6.3 kernel and tested with X and 
without X, in console mode and no KMS. My machine is way more stable 
than with previous 4.5.* and 4.4.* kernels I tried.

With 4.6.3 kernel and X running, I had only one freeze during Firefox 
session with video playback. For the rest of two days of testing, no hang.

I was not able to hang the machine during another 2 days of testing with 
4.6.3 kernel and console mode with KMS disabled. It's fair to say, that 
stress testing of GFX is quite limited when running in console mode :-). 
I tried hard with mplayer with libcaca and with repeated kernel 
compilation task. No hang occured.

My conclussion is that 4.6.3 is surelly a huge improvement, compared to 
4.5 and 4.4. kernels regarding Bay trail stability issue.

Michal Feix

