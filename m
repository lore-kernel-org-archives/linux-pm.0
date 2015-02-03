From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 2/2] CPPC: Add CPUFreq driver based on CPPC methods
Date: Tue, 03 Feb 2015 23:33:25 +0100
Message-ID: <1805804.escc39d3ai@vostro.rjw.lan>
References: <1422392638-31334-1-git-send-email-ashwin.chaugule@linaro.org> <1422392638-31334-3-git-send-email-ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63158 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752601AbbBCWKb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Feb 2015 17:10:31 -0500
In-Reply-To: <1422392638-31334-3-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: rwells@codeaurora.org, linda.knippers@hp.com, linux-pm@vger.kernel.org, Catalin.Marinas@arm.com, patches@linaro.org, linaro-acpi@lists.linaro.org, viresh.kumar@linaro.org, jaswinder.singh@linaro.org, broonie@kernel.org, arnd.bergmann@linaro.org

On Tuesday, January 27, 2015 04:03:58 PM Ashwin Chaugule wrote:
> CPPC stands for Collaborative Processor Performance Controls
> and is defined in the ACPI v5.0+ spec. It describes CPU
> performance controls on an abstract and continuous scale
> allowing the platform (e.g. remote power processor) to flexibly
> optimize CPU performance with its knowledge of power budgets
> and other architecture specific knowledge.
> 
> This patch introduces a CPUFreq driver which works with
> existing CPUFreq governors. The backend CPPC methods for
> parsing the CPPC table and reading/writing using CPPC semantics
> are abstracted away such that they can be used by any other CPPC
> based CPUFreq driver in the future.

First question: How do we ensure that this won't interact negatively with
the existing ACPI cpufreq driver?  In particular, what is there to allow
users to use the driver they want?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
