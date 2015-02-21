From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] PM / sleep: add configurable delay for pm_test
Date: Sat, 21 Feb 2015 14:56:01 -0800
Message-ID: <CAGVrzcYSHem65m6ChSF83qu5AF_fQVZj=qdV+vNNtSKZM1YLXg@mail.gmail.com>
References: <1409788535-28264-1-git-send-email-computersforpeace@gmail.com>
 <20141213025530.GO21347@ld-irv-0074> <20141213083123.GA26129@amd>
 <20141216235813.GI9759@ld-irv-0074> <20141217080947.GB2027@amd>
 <20141217091057.GH7112@brian-ubuntu> <20141217092255.GA4588@amd>
 <CAGVrzcZgwQqfBkupWkChYg8NmpKsFzWNa0jB18wN6YUuOzgvsw@mail.gmail.com> <20150221203256.GA15228@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:38908 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbbBUW4m (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 21 Feb 2015 17:56:42 -0500
In-Reply-To: <20150221203256.GA15228@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Brian Norris <computersforpeace@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Chirantan Ekbote <chirantan@chromium.org>

2015-02-21 12:32 GMT-08:00 Pavel Machek <pavel@ucw.cz>:
>
>
>
>> Considering that Brian's change are enclosed within a CONFIG_PM_DEBUG
>> ifdef, can we really use the code bloat as a technical argument here?
>
> Yes.

Help me understand a few things here:

- this particular change is enclosed within a debug option, so only
people interested in enabling PM_DEBUG will get access to it

- if we need to turn on PM_DEBUG all the time, including mainline
distributions, does that mean that:
           - portions of code existing only in PM_DEBUG should be
moved out of it because it is actually useful outside of debug option?
           - CONFIG_PM itself is not self sufficient and there are
still problems that require PM_DEBUG to be turned on?
           - should there be a second level debug option (e.g:
CONFIG_PM_DEBUG_ADV) which gates specific control knobs like PM delay?

The current 5 seconds delay is completely arbitrary and goes against
the principle of not enforcing a policy, having this configurable
brings this back in the mechanism principle.
-- 
Florian
