From: Brian Norris <briannorris@chromium.org>
Subject: Re: [RESEND PATCH 1/2] PM / sleep: print function name of callbacks
Date: Wed, 2 Nov 2016 14:02:17 -0700
Message-ID: <20161102210216.GB27786@google.com>
References: <1476923170-111986-1-git-send-email-briannorris@chromium.org>
 <1739391.aWGq2sgtym@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35879 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756776AbcKBVCV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Nov 2016 17:02:21 -0400
Received: by mail-pf0-f178.google.com with SMTP id 189so17948946pfz.3
        for <linux-pm@vger.kernel.org>; Wed, 02 Nov 2016 14:02:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1739391.aWGq2sgtym@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, linux-pm@vger.kernel.org, Chuansheng Liu <chuansheng.liu@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Tue, Nov 01, 2016 at 05:27:05AM +0100, Rafael J. Wysocki wrote:
> Any reason why you need to rely on the initcall_debug stuff instead of using
> the tracepoints we have there (for exactly the reason why you are pushing this
> patch)?

This was mentioned on the last submission. I'll paste Doug's reply from
there:

"""
On Tue, Sep 22, 2015 at 10:33 AM, Brown, Len <len.brown@intel.com>
wrote:
> have you used analyze_suspend?
> It used to parse this output, but that was abandoned
> when it cut over to using ftrace directly.
>
> https://01.org/suspendresume

Ah, good to know about.  In my case this output is enabled on shipping
devices and sometimes we get back bug reports with these prints in the
log, so I'm interested in making the prints more useful.  :)

-Doug
"""

Perhaps I should have elabotated on the RESEND...

Or is there a really good way to make use of the tracepoints for
production systems, including for crash reports? We currently get the
kernel log from pstore, but I see ftrace support has been there for a
little while too. Still, it's awfully useful to have kernel prints and
warnings interleave with initcall_debug, and it wouldn't be quite as
easy to have to piece this together between kernel log + ftrace log.

Brian
