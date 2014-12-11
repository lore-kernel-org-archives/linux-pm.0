From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 4/5] opp: handle allocation of device_opp in a separate routine
Date: Thu, 11 Dec 2014 21:52:14 +0100
Message-ID: <2316919.BxPO4eAa0q@vostro.rjw.lan>
References: <0a31e317c90f601f77cc21b80455633928c70c96.1418184737.git.viresh.kumar@linaro.org> <3480697.K2MkBymPAS@vostro.rjw.lan> <CAKohpoktdrOX8TDwqd-co+mNERS_NjewitDXguXDZO9bEWdFFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54302 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758751AbaLKUah (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Dec 2014 15:30:37 -0500
In-Reply-To: <CAKohpoktdrOX8TDwqd-co+mNERS_NjewitDXguXDZO9bEWdFFA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Thursday, December 11, 2014 08:45:22 AM Viresh Kumar wrote:
> On 11 December 2014 at 03:31, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > I've lost patches [1-2/5] somehow, but never mind.  I can get them from Patchwork.
> 
> Strange, you were always in --to for them ..
> 
> > In this one I'm wondering about the printk removal mentioned above.  Did
> > checkpatch complain about the printk?
> 
> commit ebfdc40969f24fc0cdd1349835d36e8ebae05374
> Author: Joe Perches <joe@perches.com>
> Date:   Wed Aug 6 16:10:27 2014 -0700
> 
>     checkpatch: attempt to find unnecessary 'out of memory' messages

OK

So I've applied this, but here are the rules for the future regarding
checkpatch.pl:

(1) checkpatch.pl is meant for checking changes made by a patch and *not* for
    checking the existing code.

(2) Always use common sense on top of checkpatch.pl complaints.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
