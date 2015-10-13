From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: System will not suspend with highest numbered CPU offline
 [REGRESSION][BISECTED]
Date: Tue, 13 Oct 2015 09:17:55 +0530
Message-ID: <20151013034755.GS5386@linux>
References: <001401d0e691$302127b0$90637710$@net>
 <20150908024014.GD26760@linux>
 <55F33D07.5090107@codeaurora.org>
 <2418240.peTGggLtDn@vostro.rjw.lan>
 <55F35092.7090207@codeaurora.org>
 <20151011094723.GA5386@linux>
 <561C0D5A.1040008@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34811 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbbJMDsD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2015 23:48:03 -0400
Received: by padhy16 with SMTP id hy16so7383351pad.1
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2015 20:48:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <561C0D5A.1040008@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Doug Smythies <dsmythies@telus.net>, "'Rafael J. Wysocki'" <rafael@kernel.org>, linux-pm@vger.kernel.org

On 12-10-15, 12:43, Saravana Kannan wrote:
> Did I also convince you about allowing changing of parameters for
> offline CPUs? Which would also include inactive policies?

Yes, but that requires some careful modification of the code as there
are various paths of the sysfs write path. And we need to see that we
don't do anything more than just updating the files. So, I left it for
now.

-- 
viresh
