From: Ran Shalit <ranshalit@gmail.com>
Subject: Re: suspend/resume PM criterion for application
Date: Wed, 10 Sep 2014 21:23:28 +0300
Message-ID: <CAJ2oMhJpTQjgDgEgOqvLVJg7LQjtHg2by71=98uH=vq59zTmDg@mail.gmail.com>
References: <CAJ2oMh+xmgC9mfT5QqEmMMek7SOqYE2QLVV6sPvK0CF5+56hDg@mail.gmail.com>
	<17893.1410371984@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:53732 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbaIJSX3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Sep 2014 14:23:29 -0400
Received: by mail-qc0-f175.google.com with SMTP id c9so19804674qcz.6
        for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2014 11:23:28 -0700 (PDT)
In-Reply-To: <17893.1410371984@turing-police.cc.vt.edu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Valdis.Kletnieks@vt.edu
Cc: kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-pm@vger.kernel.org

On Wed, Sep 10, 2014 at 8:59 PM,  <Valdis.Kletnieks@vt.edu> wrote:
> On Wed, 10 Sep 2014 20:26:48 +0300, Ran Shalit said:
>
>> What is usually the criterion for PM (power management) suspending
>> that application shall use ? Is it according to minimum threshold for
>> cpu load (as indication for no process) ?
>
> That will be highly application dependent.  Something that checks your email
> in the background may not care at all, as long as it gets network
> access every 5 minutes or so, and the entire system can power down for 4 minutes
> and 58 seconds as far as it cares.  If it's doing media streaming, it may
> insist on having at least one CPU burst per screen refresh, and the CPU can
> go to sleep for the rest of the 1/30th of  a second.
>
>> How usually it is performed, i.e.  is it some periodic process, which
>> wakes up periodically to check criterion for cpu load ? If so, isn't
>> it problematic in PM terms, becuase it mean that the system is resumed
>> periodically (as a result of the the periodic timer's interrupt), and
>> all devices are resumed ?
>
> No, it can be done on a per-device basis.
>
> 'powertop' is a possibly useful tool for playing with this stuff that will
> let you look at power management on the fly.

As far as I understand, suspend/respond PM is not per device, but for
all system,
and wakeup source will resume again the whole system.
I think you mean runtime suspend/resume in the answer.
