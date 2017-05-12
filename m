From: Alexey Klimov <alexey.klimov@arm.com>
Subject: Re: [PATCH] cpufreq / CPPC: Initialize policy->min to lowest
 nonlinear performance
Date: Fri, 12 May 2017 14:43:43 +0100
Message-ID: <20170512134343.GA7571@arm.com>
References: <1494542384-7502-1-git-send-email-pprakash@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932217AbdELNnw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 12 May 2017 09:43:52 -0400
Content-Disposition: inline
In-Reply-To: <1494542384-7502-1-git-send-email-pprakash@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prashanth Prakash <pprakash@codeaurora.org>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, ahs3@redhat.com, hotran@apm.com

On Thu, May 11, 2017 at 04:39:44PM -0600, Prashanth Prakash wrote:
> Description of Lowest Perfomance in ACPI 6.1 specification states:
> "Lowest Performance is the absolute lowest performance level of
> the platform. Selecting a performance level lower than the lowest
> nonlinear performance level may actually cause an efficiency penalty,
> but should reduce the instantaneous power consumption of the processor.
> In traditional terms, this represents the T-state range of performance
> levels."
> 
> Set the default value of policy->min to Lowest Nonlinear Performance
> to avoid any potential efficiency penalty.
> 
> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>

Acked-by: Alexey Klimov <alexey.klimov@arm.com>


Thanks,
Alexey
