From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: Avoid attempts to create duplicate symbolic
 links
Date: Wed, 29 Jul 2015 11:15:38 +0530
Message-ID: <20150729054538.GE21493@linux>
References: <1660815.CyKx9SEI9c@vostro.rjw.lan>
 <4080510.IQ60sVQvbL@vostro.rjw.lan>
 <20150727143935.GB18535@linux>
 <2112385.YuDJ7h1x56@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36471 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225AbbG2Fpo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2015 01:45:44 -0400
Received: by pachj5 with SMTP id hj5so81752899pac.3
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2015 22:45:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2112385.YuDJ7h1x56@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>

On 29-07-15, 03:38, Rafael J. Wysocki wrote:
> The rule is supposed to be "all of the present CPUs which do not own
> a policy should point to one, unless it doesn't exist".  The right
> approach is then to create links from them to a policy object as soon
> as we create one for them.  Waiting for something else to happen is just
> pointless and this approach covers both the offline and online CPUs, so
> I don't think that changing it would improve things really.

Ack.

-- 
viresh
