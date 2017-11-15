From: Javi Merino <javi.merino@kernel.org>
Subject: Re: [PATCH 4/4] cpu_cooling: Drop static-power related stuff
Date: Wed, 15 Nov 2017 11:31:33 +0000
Message-ID: <20171115113133.GA10252@localhost>
References: <cover.1510735482.git.viresh.kumar@linaro.org>
 <fcca009e0e10840ff5ee31c88b618a212ab69201.1510735482.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:54068 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752860AbdKOLb4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2017 06:31:56 -0500
Content-Disposition: inline
In-Reply-To: <fcca009e0e10840ff5ee31c88b618a212ab69201.1510735482.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, edubezval@gmail.com, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, lukasz.luba@arm.com, linux-kernel@vger.kernel.org, Punit Agrawal <punit.agrawal@arm.com>

On Wed, Nov 15, 2017 at 02:49:48PM +0530, Viresh Kumar wrote:
> No one has used it for the last two and half years (since it was
> introduced by commit c36cf0717631 ("thermal: cpu_cooling: implement the
> power cooling device API")), get rid of it.

Linaro used it in lsk 3.18 for the cpufreq driver for Juno.  The cpufreq
driver was converted to the generic one from dt in lsk 4.4, but the
generic cpufreq driver does not support static power because everything
has to come from device tree and we don't have a way to specify it there.

Cheers,
Javi
