From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 14/17] ata: ahci_tegra: remove power sequence from
 driver
Date: Thu, 12 Mar 2015 08:19:12 -0400
Message-ID: <20150312121912.GJ25944@htj.duckdns.org>
References: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
 <1426162518-7405-15-git-send-email-vinceh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:37386 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754276AbbCLMTR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2015 08:19:17 -0400
Content-Disposition: inline
In-Reply-To: <1426162518-7405-15-git-send-email-vinceh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vince Hsu <vinceh@nvidia.com>
Cc: thierry.reding@gmail.com, pdeschrijver@nvidia.com, swarren@wwwdotorg.org, gnurou@gmail.com, jroedel@suse.de, p.zabel@pengutronix.de, mturquette@linaro.org, pgaikwad@nvidia.com, sboyd@codeaurora.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tbergstrom@nvidia.com, airlied@linux.ie, bhelgaas@google.com, arnd@arndb.de, robh@kernel.org, will.deacon@arm.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org

On Thu, Mar 12, 2015 at 08:15:15PM +0800, Vince Hsu wrote:
> We have the generic PM domain support for Tegra SoCs now. So remove the
> duplicated sequence here.
> 
> Signed-off-by: Vince Hsu <vinceh@nvidia.com>

Can you please repost this patch w/ Hans de Goede
<hdegoede@redhat.com> cc'd?  Just reposting the patch as a reply to
itself w/ the cc added should do.

Thanks.

-- 
tejun
