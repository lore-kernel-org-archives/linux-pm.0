From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] cpufreq: ARM big LITTLE: Add generic cpufreq driver
	and its DT glue
Date: Wed, 6 Mar 2013 17:25:17 +0000
Message-ID: <20130306172517.GT17833@n2100.arm.linux.org.uk>
References: <f20e3c5e822c4bd28a3b71264d73143cc1f850b0.1362458878.git.viresh.kumar@linaro.org> <20130305105251.GL17833@n2100.arm.linux.org.uk> <CAKohponef2XNN2i8Dn7aBnzcdJeCmuGrmN3HjaBUZvBHkNSLKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55293 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716Ab3CFRZf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Mar 2013 12:25:35 -0500
Content-Disposition: inline
In-Reply-To: <CAKohponef2XNN2i8Dn7aBnzcdJeCmuGrmN3HjaBUZvBHkNSLKQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, Steve.Bannister@arm.com, linux-pm@vger.kernel.org, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Liviu.Dudau@arm.com, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, robin.randhawa@arm.com, linux-arm-kernel@lists.infradead.org, mark.hambleton@broadcom.com, linaro-kernel@lists.linaro.org, charles.garcia-tobin@arm.com

On Wed, Mar 06, 2013 at 12:38:36AM +0800, Viresh Kumar wrote:
> So how does below fix look to you?

Much better, but I think you want a better device name than just "clusterN".

Also, please get rid of that "default n" - n is the default default default
default default default.... there's no need to specify it. :)
