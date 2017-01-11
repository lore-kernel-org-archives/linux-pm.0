From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] intel_idle: work around errate VLP52 on Baytrail CPUs
Date: Wed, 11 Jan 2017 15:22:44 -0800
Message-ID: <20170111152244.360e8a82@jacob-builder>
References: <838trb233m.fsf@echidna.jochen.org>
        <CAJZ5v0jkATWSrGuR_DOfiSUFguRJ1w7gMRth1kjwYh1bSWnvGw@mail.gmail.com>
        <CA+8K-g=fXN9TWWxkV1AEEjXJLhwJEQ2PB434gKQ9Z7bL=yf+zA@mail.gmail.com>
        <CA+8K-g=VVC-13J+jU+KGyk49xHPhm5uojj0h9FcWZiC91NTiQw@mail.gmail.com>
        <CAJvTdK=sFHRo3FQ-ebWM7qVY3iLadWUFA+iacB8jwfHtJyNWGA@mail.gmail.com>
        <83ful9yue7.fsf@echidna.jochen.org>
        <CAJvTdKkJv+WfvvibR9Ly9AS5ncp1UTsm74XMX=pg8uyV9Mxupw@mail.gmail.com>
        <CA+8K-gntePuqdij7SijqcT0RXPoKi163UPwoBnBCk04zBp0BvA@mail.gmail.com>
        <CAJvTdKnuiaa4WcDYORe1O8R48dbawX1V9McbpMh-9AyAc5DLZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:63265 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750955AbdAKXVc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Jan 2017 18:21:32 -0500
In-Reply-To: <CAJvTdKnuiaa4WcDYORe1O8R48dbawX1V9McbpMh-9AyAc5DLZg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Vincent Gerris <vgerris@gmail.com>, Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Jochen Hein <jochen@jochen.org>, Linux PM <linux-pm@vger.kernel.org>, jacob.jun.pan@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, "Prusty, Subhransu S" <subhransu.s.prusty@intel.com>

On Wed, 11 Jan 2017 18:14:12 -0500
Len Brown <lenb@kernel.org> wrote:

> Re: powertop
> 
> turbostat is more useful.  The pre-release I uploaded to the bug
> report includes some baytrail specific support:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=109051#c661
> 
> > I saw your patch for auto-demotion, I will test it and report
> > within a few days. I will also do further testing with the 4.9
> > kernel. I hope we can get things stable one way or the other :).  
> 
> Current thinking is that we have multiple issues here, and enabling
> auto-demotion
> simply hides the actual root causes.
> 
> Sound is one known root cause, as Jacob pointed out.
> Hopefully we'll have a fix for that one shortly.
> 
+Vinod & Subhransu
Could you send out Baytrail VLP70 SST driver workaround patch for
testing?

> I'm testing w/o sound, and still can provoke a failure in under 30
> minutes.
> 
> Len Brown, Intel Open Source Technology Center

[
