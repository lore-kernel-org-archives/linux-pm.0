From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: System will not suspend with highest numbered CPU offline [REGRESSION][BISECTED]
Date: Mon, 12 Oct 2015 12:43:22 -0700
Message-ID: <561C0D5A.1040008@codeaurora.org>
References: <001401d0e691$302127b0$90637710$@net> <20150908024014.GD26760@linux> <55F33D07.5090107@codeaurora.org> <2418240.peTGggLtDn@vostro.rjw.lan> <55F35092.7090207@codeaurora.org> <20151011094723.GA5386@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41616 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024AbbJLTnY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2015 15:43:24 -0400
In-Reply-To: <20151011094723.GA5386@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Doug Smythies <dsmythies@telus.net>, "'Rafael J. Wysocki'" <rafael@kernel.org>, linux-pm@vger.kernel.org

On 10/11/2015 02:47 AM, Viresh Kumar wrote:
> On 11-09-15, 15:07, Saravana Kannan wrote:
>> Good to see some support. I do know Viresh doesn't like this :)
>
> Sorry for catching up late, but looks like you guys did convince me on
> this.

Did I also convince you about allowing changing of parameters for 
offline CPUs? Which would also include inactive policies?

>
> Let me get some patches out :)
>

Thanks!

-Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
