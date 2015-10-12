From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] CPPC: Add a CPUFreq driver for use with CPPC
Date: Mon, 12 Oct 2015 23:34:09 +0200
Message-ID: <1714977.kqYb6jVT6F@vostro.rjw.lan>
References: <6d24b51b0387f4ef6cc4a2517ace2e5e9731d7be.1441830300.git.ashwin.chaugule@linaro.org> <1443794641-6960-1-git-send-email-ashwin.chaugule@linaro.org> <5435965.g6l5q97a6S@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:43039 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751973AbbJLVFa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2015 17:05:30 -0400
In-Reply-To: <5435965.g6l5q97a6S@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: sudeep.holla@arm.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, viresh.kumar@linaro.org, rwells@codeaurora.org

On Monday, October 12, 2015 11:23:01 PM Rafael J. Wysocki wrote:
> On Friday, October 02, 2015 10:04:01 AM Ashwin Chaugule wrote:
> > This driver utilizes the methods introduced in a previous
> > patch titled - "ACPI: Introduce CPU performance controls using CPPC"
> > and enables usage with existing CPUFreq governors.
> > 
> > Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> > Reviewed-by: Al Stone <al.stone@linaro.org>
> 
> This doesn't seem to apply for me, care to refresh (on top of my
> bleeding-edge branch)?

Never mind, I've resolved this already.

Thanks,
Rafael

