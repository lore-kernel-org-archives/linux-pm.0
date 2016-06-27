From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 11/14] drivers: firmware: psci: Allow OS Initiated
 suspend mode
Date: Mon, 27 Jun 2016 11:12:31 +0100
Message-ID: <20160627101231.GB1113@leverpostej>
References: <1466624209-27432-1-git-send-email-lina.iyer@linaro.org>
 <1466624209-27432-12-git-send-email-lina.iyer@linaro.org>
 <CAGm_ybjO+jAN62fqFyVrw_+5LOnUumEfn8kxmDa+s5ap0Bqk9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39095 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750870AbcF0KMj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 27 Jun 2016 06:12:39 -0400
Content-Disposition: inline
In-Reply-To: <CAGm_ybjO+jAN62fqFyVrw_+5LOnUumEfn8kxmDa+s5ap0Bqk9A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vikas Sajjan <sajjan.linux@gmail.com>, sudeep.holla@arm.com
Cc: Lina Iyer <lina.iyer@linaro.org>, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, k.kozlowski@samsung.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, ahaslam@baylibre.com, linux-arm-msm@vger.kernel.org, sboyd@codeaurora.org, geert@linux-m68k.org, andy.gross@linaro.org, mtitinger@baylibre.com

On Fri, Jun 24, 2016 at 09:55:20AM +0530, Vikas Sajjan wrote:
> On Thu, Jun 23, 2016 at 1:06 AM, Lina Iyer <lina.iyer@linaro.org> wrote:
> > +static int __init psci_1_0_init(struct device_node *np)
> > +{
> > +       int ret;
> > +
> > +       ret = psci_0_2_init(np);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /* Check if PSCI OSI mode is available */
> > +       ret = psci_features(psci_function_id[PSCI_FN_CPU_SUSPEND]);
> > +       if (ret & PSCI_1_0_OS_INITIATED) {
> > +               ret = psci_features(PSCI_1_0_FN_SET_SUSPEND_MODE);
> > +               if (!ret)
> > +                       psci_has_osi_pd = true;
> 
> IMHO, its better to have this done in psci_init_cpu_suspend() itself
> for 2 reasons
> 
> a] psci_init_cpu_suspend() already calls
> psci_features(psci_function_id[PSCI_FN_CPU_SUSPEND])
> b] by moving this in psci_init_cpu_suspend() we make this support
> available even for ACPI platforms, since psci_acpi_init() calls
> psci_probe() and this calls  psci_init_cpu_suspend() for
> PSCI_VERSION_MAJOR(ver) >= 1

For ACPI platforms it is necessary to go through a handshake to
determine whether LPI can use OSI (see 6.2.11.2 in the ACPI 6.1 spec).
So there will have to be some ACPI-specific code to determine whether
OSI should be used.

We will probably have to an ACPI-specific wrapper for
psci_init_cpu_suspend to cater for that. I don't think that
psci_init_cpu_suspend itself should be in charge of deciding whether to
enable OSI.

Thanks,
Mark.
