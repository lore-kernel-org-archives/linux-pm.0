From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v6 09/11] cpuidle/powernv: Use CPUIDLE_STATE_MAX instead of MAX_POWERNV_IDLE_STATES
Date: Mon, 13 Jun 2016 22:58:52 +0200
Message-ID: <1824456.bQhIAi46Pe@vostro.rjw.lan>
References: <1465404871-5406-1-git-send-email-shreyas@linux.vnet.ibm.com> <1465404871-5406-10-git-send-email-shreyas@linux.vnet.ibm.com> <20160613150150.GE10634@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160613150150.GE10634@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, mpe@ellerman.id.au, benh@au1.ibm.com, paulus@ozlabs.org, mikey@neuling.org, ego@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, June 13, 2016 05:01:50 PM Daniel Lezcano wrote:
> On Wed, Jun 08, 2016 at 11:54:29AM -0500, Shreyas B. Prabhu wrote:
> > Use cpuidle's CPUIDLE_STATE_MAX macro instead of powernv specific
> > MAX_POWERNV_IDLE_STATES.
> > 
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: linux-pm@vger.kernel.org
> > Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> > ---
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Since this seems to depend on some other patches in the series, I'm expecting
it to go in along with the patches it depends on.

Thanks,
Rafael
