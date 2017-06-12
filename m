From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: conservative: Allow down_threshold to take values from 1 to 10
Date: Mon, 12 Jun 2017 14:23:28 +0200
Message-ID: <3062414.lj8A9ADAOY@aspire.rjw.lan>
References: <1497169719-13613-1-git-send-email-twilczynski@naver.com> <20170612034035.GB5297@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:54199 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751944AbdFLMaf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2017 08:30:35 -0400
In-Reply-To: <20170612034035.GB5297@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Tomasz =?utf-8?B?V2lsY3p5xYRza2k=?= <twilczynski@naver.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, June 12, 2017 09:10:35 AM Viresh Kumar wrote:
> On 11-06-17, 17:28, Tomasz Wilczyński wrote:
> > Commit 27ed3cd2ebf4cd78b198be9758c538cdede36d8a ("cpufreq: conservative:
> > Fix the logic in frequency decrease checking") removed the 10 point
> > substraction when comparing the load against down_threshold but did not
> > remove the related limit for the down_threshold value. As a result,
> > down_threshold lower than 11 is not allowed even though values from
> > 1 to 10 do work correctly too. The comment ("cannot be lower than 11
> > otherwise freq will not fall") is also not true after removing the
> > substraction.
> > 
> > For this reason, allow down_threshold to take any value from 1 to 99
> > and fix the related comment.
> > 
> > Signed-off-by: Tomasz Wilczyński <twilczynski@naver.com>
> 
> Please add Fixes tag and relevant kernel release for stable tag.

Actually, the Fixes: tag would be sufficient and then adding it would be
appreciated.

No need to resend the patch, though.

Thanks,
Rafael
