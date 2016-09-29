From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: Regression in 4.8 - CPU speed set very low
Date: Thu, 29 Sep 2016 08:56:16 -0700
Message-ID: <1475164576.5547.10.camel@linux.intel.com>
References: <f89dffb9-cc78-9849-9539-74ce89e773cd@lwfinger.net>
         <CAJZ5v0j3fJ7pDoR+LhY6x1T0yQEhq6omFL7-BrBcMy68eFiMMg@mail.gmail.com>
         <5271ed6f-5798-e930-d7fd-17fe6bb7ea96@lwfinger.net>
         <16590757.26uEfRfeet@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:12340 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753890AbcI2P64 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 29 Sep 2016 11:58:56 -0400
In-Reply-To: <16590757.26uEfRfeet@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Larry Finger <Larry.Finger@lwfinger.net>, Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Doug Smythies <dsmythies@telus.net>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Thu, 2016-09-29 at 14:19 +0200, Rafael J. Wysocki wrote:

[...]

> > My laptop was inadvertently put to sleep while I was gone. I forgot
> > to leave a 
> > note for my wife and she quieted the noisy cpu fan. :)
> It looks like in 4.8-rc we made a change that caused the "high" trip
> point to
> be acted on.
This high trip point we don't expose in thermal subsystem (the thermal
 zone dump didn't show this anywhere as a trip). This is exposed by
core-dts driver only. This is the point BIOS is supposed to act, I
guess that's why you are seeing 50% clock modulation. 


Are you running thermald 

What is?
# ps -e | grep thermald


> 
> Srinivas, Rui, do you recall what that can be?
> 
> One more question (I think I asked it previously): In the failing
> case
> (4.8-rc1 and later), when the frequency drops down to the 400 MHz,
> does it
> ever go back higher or is it stuck at that level forever?
> 
> In any case, it may help to file a bug at bugzilla.kernel.org against
> CPU/thermal or similar and let me know the bug number.  We'll need to
> collect some tracepoint data to debug this and some place to put them
> into for easy reference.
Yes, this is good idea.

Thanks,
Srinivas

