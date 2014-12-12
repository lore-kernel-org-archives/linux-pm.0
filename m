From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/5] opp: handle allocation of device_opp in a separate routine
Date: Fri, 12 Dec 2014 09:04:18 +0530
Message-ID: <CAKohpo=ZmGpqg8hHDO+sOE7jwy8FMP5y4w5hCRgTsg9hj7eoNg@mail.gmail.com>
References: <0a31e317c90f601f77cc21b80455633928c70c96.1418184737.git.viresh.kumar@linaro.org>
	<3480697.K2MkBymPAS@vostro.rjw.lan>
	<CAKohpoktdrOX8TDwqd-co+mNERS_NjewitDXguXDZO9bEWdFFA@mail.gmail.com>
	<2316919.BxPO4eAa0q@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:46771 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933200AbaLLDeT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Dec 2014 22:34:19 -0500
Received: by mail-oi0-f54.google.com with SMTP id u20so4694911oif.13
        for <linux-pm@vger.kernel.org>; Thu, 11 Dec 2014 19:34:19 -0800 (PST)
In-Reply-To: <2316919.BxPO4eAa0q@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 12 December 2014 at 02:22, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> OK
>
> So I've applied this, but here are the rules for the future regarding
> checkpatch.pl:
>
> (1) checkpatch.pl is meant for checking changes made by a patch and *not* for
>     checking the existing code.
>
> (2) Always use common sense on top of checkpatch.pl complaints.

Correct, normally I do ignore the warnings for cases which I don't care about.
I did react to this one because there have been patches going around removing
print messages on allocation failures. And I didn't wanted to get another one
for this and so removed it in my patch only..

--
viresh
