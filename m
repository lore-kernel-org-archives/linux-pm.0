From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Fix runtime warnings on systems with shared core clocks
Date: Tue, 2 Jul 2013 16:02:32 +0530
Message-ID: <CAKohponf+bQ3KowmbBhAq9+MGMa8C_6RQvvDvkOiSHkir+jO_g@mail.gmail.com>
References: <1372724227-17209-1-git-send-email-broonie@kernel.org>
	<CAKohponeEC=CGzJhgCY+Cvwna6YkkRBkANjYSAqP9jf8qfJ2yA@mail.gmail.com>
	<20130702094831.GA27646@sirena.org.uk>
	<CAKohpom0NOymffysneOcygFHT9QTMgPA+BVKmoZTMg9bUpaedw@mail.gmail.com>
	<20130702102910.GG27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:51134 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932548Ab3GBKcd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jul 2013 06:32:33 -0400
Received: by mail-qc0-f174.google.com with SMTP id m15so3499696qcq.5
        for <linux-pm@vger.kernel.org>; Tue, 02 Jul 2013 03:32:32 -0700 (PDT)
In-Reply-To: <20130702102910.GG27646@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

On 2 July 2013 15:59, Mark Brown <broonie@kernel.org> wrote:
> That seems to work, yes.
>
> Tested-by: Mark Brown <broonie@linaro.org>

Thanks.

@Rafael: I will send it separately to you.

> If you're forced to do stuff like that then don't include the patch in
> the body of the e-mail, it just makes everything worse.  Not only is the
> copy in the body of the e-mail broken but there's now two copies so
> tools like git am get even more upset as they may potentially see some
> of the hunks twice.

I do it so that people can review it. I still believe its important.
