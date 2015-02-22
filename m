From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH] PM / sleep: add configurable delay for pm_test
Date: Sun, 22 Feb 2015 00:23:14 -0800
Message-ID: <20150222082314.GA24441@norris-Latitude-E6410>
References: <20141213025530.GO21347@ld-irv-0074>
 <20141213083123.GA26129@amd>
 <20141216235813.GI9759@ld-irv-0074>
 <20141217080947.GB2027@amd>
 <20141217091057.GH7112@brian-ubuntu>
 <20141217092255.GA4588@amd>
 <CAGVrzcZgwQqfBkupWkChYg8NmpKsFzWNa0jB18wN6YUuOzgvsw@mail.gmail.com>
 <20150221203256.GA15228@amd>
 <CAGVrzcYSHem65m6ChSF83qu5AF_fQVZj=qdV+vNNtSKZM1YLXg@mail.gmail.com>
 <20150221232429.GA3519@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:44330 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734AbbBVIXV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 22 Feb 2015 03:23:21 -0500
Content-Disposition: inline
In-Reply-To: <20150221232429.GA3519@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Florian Fainelli <f.fainelli@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Chirantan Ekbote <chirantan@chromium.org>

On Sun, Feb 22, 2015 at 12:24:29AM +0100, Pavel Machek wrote:
> And you also want to check the kernel parameters, they are modifiable
> in runtime in at least same cases.

I forgot about this fact. In this case, I think this satisfies all that
we need. So we can do something like this at runtime:

   # echo 30 > /sys/module/suspend/parameters/pm_test_delay

I'll send a patch shortly.

Brian
