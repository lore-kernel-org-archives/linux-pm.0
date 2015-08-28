From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH V1 Resend 02/10] PM / OPP: Drop unlikely before
 IS_ERR(_OR_NULL)
Date: Fri, 28 Aug 2015 15:52:46 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1508281551320.25821@pobox.suse.cz>
References: <cover.1439375087.git.viresh.kumar@linaro.org> <455a29a594b92b9ba06b14249d8f61a7ffbbecc1.1439375087.git.viresh.kumar@linaro.org> <4143341.O8kzUSgY49@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49014 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963AbbH1Nws (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 28 Aug 2015 09:52:48 -0400
In-Reply-To: <4143341.O8kzUSgY49@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>

On Fri, 28 Aug 2015, Rafael J. Wysocki wrote:

> > IS_ERR(_OR_NULL) already contain an 'unlikely' compiler flag and there
> > is no need to do that again from its callers. Drop it.
> > 
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Did that go anywhere or should I apply it?

I didn't take it yet, so feel free to do so if you want.

With series like this, I usually wait a couple weeks and the pick the ones 
which haven't been picked into maintainer trees (I check that by looking 
for its presence in linux-next) through trivial.git afterwards.

-- 
Jiri Kosina
SUSE Labs

