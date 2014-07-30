From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq, store_scaling_governor requires policy->rwsem to be held for duration of changing governors [v2]
Date: Wed, 30 Jul 2014 23:40:56 +0200
Message-ID: <1816455.s1k7EgIPj9@vostro.rjw.lan>
References: <1406634362-811-1-git-send-email-prarit@redhat.com> <1727443.QxEjMbNBsd@vostro.rjw.lan> <53D8FEB1.5040808@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62052 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751440AbaG3VWX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jul 2014 17:22:23 -0400
In-Reply-To: <53D8FEB1.5040808@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Lenny Szubowicz <lszubowi@redhat.com>, linux-pm@vger.kernel.org

On Wednesday, July 30, 2014 10:18:25 AM Prarit Bhargava wrote:
> 
> On 07/29/2014 08:03 PM, Rafael J. Wysocki wrote:
> > On Tuesday, July 29, 2014 07:46:02 AM Prarit Bhargava wrote:

[cut]

> >> This patch effectively reverts commit 955ef483.
> > 
> > OK, I'm convinced by this.
> > 
> > I suppose we should push it for -stable from 3.10 through 3.15.x, right?
> 
> Rafael, I think that is a good idea.  I'm not sure what the protocol is for
> adding stable@kernel.org though ...

I'll take care of this, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
