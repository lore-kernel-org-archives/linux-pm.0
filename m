From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: PROBLEM: Kernel OOPS and possible system freeze after concurrent
 writing to cpufreq/scaling_governor (Resend)
Date: Tue, 9 Sep 2014 09:48:34 +0530
Message-ID: <CAKohpom82S1Cn+oW362QTKdB+BBVp=JuHUTcak8w0p1H9krnZg@mail.gmail.com>
References: <1405522398.2348.42.camel@x200t>
	<1410164208.6159.18.camel@x200t>
	<CAKohpo=DeQQq505U_EDsJ+5dPGPuSOypx_YbTYW5owj4FDYLpA@mail.gmail.com>
	<3737419.nVAGuIilZz@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:55708 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755844AbaIIESj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Sep 2014 00:18:39 -0400
Received: by mail-oi0-f44.google.com with SMTP id x69so5527392oia.31
        for <linux-pm@vger.kernel.org>; Mon, 08 Sep 2014 21:18:34 -0700 (PDT)
In-Reply-To: <3737419.nVAGuIilZz@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: =?UTF-8?Q?Robert_Sch=C3=B6ne?= <robert.schoene@tu-dresden.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Prarit Bhargava <prarit@redhat.com>, Saravana Kannan <skannan@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>

On 9 September 2014 02:44, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> Some mailer (mine or yours) mangled the attachment.  I can see it in patchwork,
> though.

I didn't knew that they play with attachments as well :)

> It looks reasonable to me.
>
> Am I supposed to pick it up?  If so, do we need it in -stable?  If so, which
> -stable (or what commit does it fix)?

I wanted to send this separately and so attached it here. I have sent
two patches
to you with details about stable as well.
