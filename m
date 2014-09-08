From: Robert =?ISO-8859-1?Q?Sch=F6ne?= <robert.schoene@tu-dresden.de>
Subject: Re: PROBLEM: Kernel OOPS and possible system freeze after
 concurrent writing to cpufreq/scaling_governor (Resend)
Date: Mon, 08 Sep 2014 14:28:42 +0200
Message-ID: <1410179322.25768.7.camel@x200t>
References: <1405522398.2348.42.camel@x200t> <1406185912.2406.3.camel@x200t>
	 <CAKohpomo_Qoc-ioC-L-n6z19SLMgCfzebec7pqkq9y86gt61HA@mail.gmail.com>
	 <1406277769.2399.4.camel@x200t>
	 <CAKohpomDkU1nBP4+1EkSdDxQESD+1b6kmaELVfGEifqTL+ZOdg@mail.gmail.com>
	 <1410164208.6159.18.camel@x200t>
	 <CAKohpo=DeQQq505U_EDsJ+5dPGPuSOypx_YbTYW5owj4FDYLpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-7"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.zih.tu-dresden.de ([141.30.67.73]:42317 "EHLO
	mailout2.zih.tu-dresden.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753121AbaIHM2w (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Sep 2014 08:28:52 -0400
In-Reply-To: <CAKohpo=DeQQq505U_EDsJ+5dPGPuSOypx_YbTYW5owj4FDYLpA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Prarit Bhargava <prarit@redhat.com>, Saravana Kannan <skannan@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>

Am Montag, den 08.09.2014, 16:26 +-0530 schrieb Viresh Kumar:
+AD4 Can you please try attached patch with the revert earlier suggested?
+AD4 To make it clear again, cherry-pick: 19c7630 and then apply  this
+AD4 patch.

The patch works for me.

Thank you+ACE

PS: With this patch I get an EINVAL when writing fails (instead of an
EBUSY). Is this intended? 


