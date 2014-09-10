From: Ran Shalit <ranshalit@gmail.com>
Subject: Re: suspend/resume PM criterion for application
Date: Wed, 10 Sep 2014 21:58:48 +0300
Message-ID: <CAJ2oMhLnP7TpP3caycqVS0xHRE3tf=+2vREE6H1NradsmFmH4A@mail.gmail.com>
References: <CAJ2oMh+xmgC9mfT5QqEmMMek7SOqYE2QLVV6sPvK0CF5+56hDg@mail.gmail.com>
	<17893.1410371984@turing-police.cc.vt.edu>
	<CAJ2oMhJpTQjgDgEgOqvLVJg7LQjtHg2by71=98uH=vq59zTmDg@mail.gmail.com>
	<20227.1410374378@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:48981 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701AbaIJS6t (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Sep 2014 14:58:49 -0400
Received: by mail-qg0-f52.google.com with SMTP id i50so5275982qgf.39
        for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2014 11:58:48 -0700 (PDT)
In-Reply-To: <20227.1410374378@turing-police.cc.vt.edu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Valdis.Kletnieks@vt.edu
Cc: kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-pm@vger.kernel.org

On Wed, Sep 10, 2014 at 9:39 PM,  <Valdis.Kletnieks@vt.edu> wrote:
> On Wed, 10 Sep 2014 21:23:28 +0300, Ran Shalit said:
>
>> As far as I understand, suspend/respond PM is not per device, but for
>> all system,
>> and wakeup source will resume again the whole system.
>> I think you mean runtime suspend/resume in the answer.
>
> The original question didn't specify. You said "suspending that application",
> not the entire system.
>
> And runtime suspend/resume of devices and even the CPU does fit within
> your original question constraints.
>
> If you're looking at system-wide suspend/resume specificially, there's
> two basic schemes in use:
>
> 1) User hits a button, acpid or similar notices, and does a suspend to
> disk/ram/papertape/whatever.
>
> 2) User hits a button, closes the lid, or a user inactivity timer expires.
> A process notices, and asks all processes which have registered for suspend
> notifications "Is it OK if we suspend?", and if nobody says "Nay", it does it.
> If a process complains, it is repeatedly polled until it finishes whatever it
> was doing and says "OK now".

Hi Veldis,

The second scheme you mention is what I am required to achieve, but it
raises some question:
> or a user inactivity timer expires. A process notices...
1. How can I make a process to notice this inactivity ? Do you think
it can be implemented by some periodic process who check if there is
activity ? It returns to the original question I raised, that I will
use some periodic process who checks maybe cpu load or something like
that. What do you think ?
> and asks all processes which have registered for suspend notifications "Is it OK if we suspend?
2. What Do you mean here by process ?  Do you mean SW process which
register for suspend notification (how do we do this) ? What about
devices which register for suspend/resume. Must they accept the
suspend ?

Thanks very much,
Ran
