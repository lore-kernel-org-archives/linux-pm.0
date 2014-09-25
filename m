From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Domains: Remove legacy API for adding devices through DT
Date: Fri, 26 Sep 2014 01:38:49 +0200
Message-ID: <2421607.ZNPMXALrer@vostro.rjw.lan>
References: <1411660199-2022-1-git-send-email-ulf.hansson@linaro.org> <7hppej9ws2.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53238 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751708AbaIYXTA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Sep 2014 19:19:00 -0400
In-Reply-To: <7hppej9ws2.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Tomasz Figa <tomasz.figa@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>

On Thursday, September 25, 2014 03:10:21 PM Kevin Hilman wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
> 
> > There are no active clients of the legacy API and we now also have a
> > better way to handle genpd DT support. So let's remove the legacy API.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Acked-by: Kevin Hilman <khilman@linaro.org>

I'vew queued this up for 3.18, but the ACK didn't make it.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
