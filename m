From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 3/8] cpufreq: powerenv: Fix memory leak
Date: Thu, 02 Jun 2016 21:08:08 +1000
Message-ID: <1464865688.11826.1.camel@ellerman.id.au>
References: <cover.1464776797.git.viresh.kumar@linaro.org>
	 <f67b4b395c777a3e933ab51eafcd76b1299bf1fb.1464776797.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:34221 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932355AbcFBLIK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 2 Jun 2016 07:08:10 -0400
In-Reply-To: <f67b4b395c777a3e933ab51eafcd76b1299bf1fb.1464776797.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org

On Wed, 2016-06-01 at 16:04 +0530, Viresh Kumar wrote:

> The policy is copied (unnecessarily) and is never freed. Fix it by just
> getting a reference to the existing policy structure and putting it
> back.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

When was it broken, always?

Cc: stable ?

cheers

