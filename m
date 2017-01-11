From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] intel_idle: work around errate VLP52 on Baytrail CPUs
Date: Wed, 11 Jan 2017 18:14:12 -0500
Message-ID: <CAJvTdKnuiaa4WcDYORe1O8R48dbawX1V9McbpMh-9AyAc5DLZg@mail.gmail.com>
References: <838trb233m.fsf@echidna.jochen.org> <CAJZ5v0jkATWSrGuR_DOfiSUFguRJ1w7gMRth1kjwYh1bSWnvGw@mail.gmail.com>
 <CA+8K-g=fXN9TWWxkV1AEEjXJLhwJEQ2PB434gKQ9Z7bL=yf+zA@mail.gmail.com>
 <CA+8K-g=VVC-13J+jU+KGyk49xHPhm5uojj0h9FcWZiC91NTiQw@mail.gmail.com>
 <CAJvTdK=sFHRo3FQ-ebWM7qVY3iLadWUFA+iacB8jwfHtJyNWGA@mail.gmail.com>
 <83ful9yue7.fsf@echidna.jochen.org> <CAJvTdKkJv+WfvvibR9Ly9AS5ncp1UTsm74XMX=pg8uyV9Mxupw@mail.gmail.com>
 <CA+8K-gntePuqdij7SijqcT0RXPoKi163UPwoBnBCk04zBp0BvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36407 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760118AbdAKXON (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Jan 2017 18:14:13 -0500
Received: by mail-qt0-f196.google.com with SMTP id l7so359959qtd.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Jan 2017 15:14:13 -0800 (PST)
In-Reply-To: <CA+8K-gntePuqdij7SijqcT0RXPoKi163UPwoBnBCk04zBp0BvA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Gerris <vgerris@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Jochen Hein <jochen@jochen.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Linux PM <linux-pm@vger.kernel.org>

Re: powertop

turbostat is more useful.  The pre-release I uploaded to the bug
report includes some baytrail specific support:

https://bugzilla.kernel.org/show_bug.cgi?id=109051#c661

> I saw your patch for auto-demotion, I will test it and report within a few days.
> I will also do further testing with the 4.9 kernel. I hope we can get
> things stable one way or the other :).

Current thinking is that we have multiple issues here, and enabling
auto-demotion
simply hides the actual root causes.

Sound is one known root cause, as Jacob pointed out.
Hopefully we'll have a fix for that one shortly.

I'm testing w/o sound, and still can provoke a failure in under 30 minutes.

Len Brown, Intel Open Source Technology Center
