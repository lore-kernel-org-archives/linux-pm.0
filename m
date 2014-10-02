From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: cpufreq v3.17-rc7 error: "cpufreq: cpufreq_resume: Failed to
 start governor for policy: f6909a00"
Date: Thu, 02 Oct 2014 18:33:28 +0200
Message-ID: <1412267608.19413.68.camel@x220>
References: <1412250350.3060.9.camel@x41> <1412250911.3060.13.camel@x41>
	 <2550705.C9YWxWdtP6@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cpsmtpb-ews08.kpnxchange.com ([213.75.39.13]:56304 "EHLO
	cpsmtpb-ews08.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751462AbaJBQdb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Oct 2014 12:33:31 -0400
In-Reply-To: <2550705.C9YWxWdtP6@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2014-10-02 at 18:38 +0200, Rafael J. Wysocki wrote:
> Can you please try linux-pm.git/linux-next?  There's a commit from Viresh in
> there with a chance to fix this and which I'm going to push to Linus shortly?

Do you mean b1b12babe3b72cfb08b875245e5a5d7c2747c772 ("cpufreq: update
'cpufreq_suspended' after stopping governors")? Does that require
anything else from that tree? It doesn't matter much, but if possible I
would prefer to add as few patches as I can get away with.


Paul Bolle

