From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 4/6] ARM64: cpuidle: Rename cpu_init_idle to a common
 function name
Date: Fri, 20 Mar 2015 17:26:40 +0000
Message-ID: <20150320172639.GK3421@e104818-lin.cambridge.arm.com>
References: <1425385777-14766-1-git-send-email-daniel.lezcano@linaro.org>
 <1425385777-14766-5-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40785 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993AbbCTR0o (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 20 Mar 2015 13:26:44 -0400
Content-Disposition: inline
In-Reply-To: <1425385777-14766-5-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, devicetree@vger.kernel.org, arnd@arndb.de, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, lina.iyer@linaro.org, linux-arm-kernel@lists.infradead.org

On Tue, Mar 03, 2015 at 01:29:35PM +0100, Daniel Lezcano wrote:
> With this change the cpuidle-arm64.c file calls the same function name
> for both ARM and ARM64.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

That said, if you find some names to avoid the arm_ prefix it's even
better but either way my ack still stands.
