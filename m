From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V7 5/6] cpufreq: Restart governor as soon as possible
Date: Tue, 09 Jun 2015 01:27:22 +0200
Message-ID: <1969774.NfEI2hyvTT@vostro.rjw.lan>
References: <cover.1433767914.git.viresh.kumar@linaro.org> <5802c619494ba09e5c7621722e5a0778519c6a98.1433767914.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63268 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753520AbbFHXBf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2015 19:01:35 -0400
In-Reply-To: <5802c619494ba09e5c7621722e5a0778519c6a98.1433767914.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>

On Monday, June 08, 2015 06:25:31 PM Viresh Kumar wrote:
> On cpu hot-unplug, we don't need to wait for POST_DEAD notification to
> restart the governor if the policy has atleast one online cpu left. We
> can restart the governor right from the DOWN_PREPARE notification
> instead.

Any explanation why this is correct here?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
