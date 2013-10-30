From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 0/2] cpufreq support for the big.LITTLE switcher
Date: Wed, 30 Oct 2013 22:52:49 +0100
Message-ID: <7822477.lBueQHUY4E@vostro.rjw.lan>
References: <1383162281-24204-1-git-send-email-nicolas.pitre@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1383162281-24204-1-git-send-email-nicolas.pitre@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: viresh.kumar@linaro.org, sudeep.karkadanagesha@arm.com, dave.martin@arm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, October 30, 2013 03:44:39 PM Nicolas Pitre wrote:
> This is the third and final set of patches towards a fully functional
> and production quality switcher solution for big.LITTLE systems,
> establishing a landmark to compare against for any scheduler based
> solution meant to eventually surpass the switcher's power efficiency
> available in the mainline kernel.
> 
> Rationale for this code: http://lwn.net/Articles/481055/
> 
> The first and second patch sets have already been merged by RMK.  They
> implement the core switcher mechanism.  This set adds the necessary code
> to drive the switcher based on cpufreq governor decisions.
> 
> This set (v2) was rebased on top of the latest linux-pm tree as
> requested by Rafael.

Queued up for 3.13, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
