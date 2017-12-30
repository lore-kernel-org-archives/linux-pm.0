From: Javi Merino <javi.merino@kernel.org>
Subject: Re: [PATCH V2 4/4] cpu_cooling: Drop static-power related stuff
Date: Sat, 30 Dec 2017 12:52:30 +0100
Message-ID: <20171230115230.GA17853@tesla>
References: <cover.1512451487.git.viresh.kumar@linaro.org>
 <55020cb5e2701942b0613c12bd0c911662df643e.1512451487.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36424 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbdL3Lwe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 30 Dec 2017 06:52:34 -0500
Content-Disposition: inline
In-Reply-To: <55020cb5e2701942b0613c12bd0c911662df643e.1512451487.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, edubezval@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, amit.kachhap@gmail.com, rui.zhang@intel.com, ionela.voinescu@arm.com

On Tue, Dec 05, 2017 at 11:02:46AM +0530, Viresh Kumar wrote:
> No one has used it for the last two and half years (since it was
> introduced by commit c36cf0717631 ("thermal: cpu_cooling: implement the
> power cooling device API")), get rid of it.

That commit c36cf0717631 ("thermal: cpu_cooling: implement the power
cooling device API") also added documentation for it.  You should
remove the documentation, to keep it in sync.

> Cc: Javi Merino <javi.merino@arm.com>
> Cc: Punit Agrawal <punit.agrawal@arm.com>
> Acked-by: Eduardo Valentin <edubezval@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/thermal/cpu_cooling.c  | 106 +++++------------------------------------
>  include/linux/cpu_cooling.h    |   3 --
>  include/trace/events/thermal.h |  10 ++--
>  3 files changed, 16 insertions(+), 103 deletions(-)
