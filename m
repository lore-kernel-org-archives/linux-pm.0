From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: cpufreq_stats NULL deref on second system suspend
Date: Mon, 09 Sep 2013 14:01:32 -0600
Message-ID: <522E291C.6040304@wwwdotorg.org>
References: <522E1FEF.6080803@wwwdotorg.org> <114906795.XcxkLqsNxY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:42282 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755272Ab3IIUBe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Sep 2013 16:01:34 -0400
In-Reply-To: <114906795.XcxkLqsNxY@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 09/09/2013 02:01 PM, Rafael J. Wysocki wrote:
> On Monday, September 09, 2013 01:22:23 PM Stephen Warren wrote:
>> Viresh,
>>
>> I'm seeing the crash below when suspending my system for the second time.
>>
>> I can avoid this with the following patch, which adds a check which
>> already exists in all-but-one other places that the same lookup is made:
> 
> Which kernel did you test?

next-20130909.
