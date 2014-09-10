From: Ran Shalit <ranshalit@gmail.com>
Subject: Re: suspend/resume PM criterion for application
Date: Wed, 10 Sep 2014 22:31:44 +0300
Message-ID: <CAJ2oMh+9q12EEV3u2oXMnAVijSGORCC6JGpScdSqDWdDHuK=-A@mail.gmail.com>
References: <CAJ2oMh+xmgC9mfT5QqEmMMek7SOqYE2QLVV6sPvK0CF5+56hDg@mail.gmail.com>
	<17893.1410371984@turing-police.cc.vt.edu>
	<CAJ2oMhJpTQjgDgEgOqvLVJg7LQjtHg2by71=98uH=vq59zTmDg@mail.gmail.com>
	<20227.1410374378@turing-police.cc.vt.edu>
	<CAJ2oMhLnP7TpP3caycqVS0xHRE3tf=+2vREE6H1NradsmFmH4A@mail.gmail.com>
	<23104.1410377100@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:33263 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752307AbaIJTbp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Sep 2014 15:31:45 -0400
Received: by mail-qa0-f47.google.com with SMTP id x12so17993962qac.34
        for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2014 12:31:45 -0700 (PDT)
In-Reply-To: <23104.1410377100@turing-police.cc.vt.edu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc: kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-pm@vger.kernel.org

On Wed, Sep 10, 2014 at 10:25 PM,  <Valdis.Kletnieks@vt.edu> wrote:
> On Wed, 10 Sep 2014 21:58:48 +0300, Ran Shalit said:
>
>> 1. How can I make a process to notice this inactivity ? Do you think
>> it can be implemented by some periodic process who check if there is
>> activity ? It returns to the original question I raised, that I will
>> use some periodic process who checks maybe cpu load or something like
>> that. What do you think ?
>
> That's going to depend on your system and what processes are running.
>
> You may have an MP3 player going that doesn't take much CPU at all - but
> shutting down because the user hasn't hit a button in 47 minutes will probably
> irritate the user no end.  Or there may be a screensaver running that takes
> twice as much CPU as the MP3 player, but is totally OK on the system
> suspending whenever the rest of the system wants it.
>
> You're going to have to look at your system design, and decide for yourself
> what the criteria are.
>
>
>> 2. What Do you mean here by process ?  Do you mean SW process which
>> register for suspend notification (how do we do this) ? What about
>> devices which register for suspend/resume. Must they accept the
>> suspend ?
>
> I believe Android already has libraries and monitor processes for this.
>
> It's really hard to give more specific advice without knowing what your
> hardware, software, and usage is.

Ok, Thanks, I just tried to understand and learn from your previous answer.
I have OMAP Soc and knows that the linux SDK supports suspend/resume
and other mechnism. I did n't hear about the notification before.

Thanks, Ran
