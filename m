From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] intel_pstate, decrease number of "HWP enabled" messages
Date: Wed, 28 Oct 2015 04:28:32 +0100
Message-ID: <11756741.Zefh4Qsnkv@vostro.rjw.lan>
References: <1445521411-28850-1-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:46216 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755110AbbJ1C7f (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2015 22:59:35 -0400
In-Reply-To: <1445521411-28850-1-git-send-email-prarit@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-kernel@vger.kernel.org, Kristen Carlson Accardi <kristen@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org

On Thursday, October 22, 2015 09:43:31 AM Prarit Bhargava wrote:
> When booting an HWP enabled system the kernel displays one "HWP enabled"
> message for each cpu.  The messages are superfluous since HWP is globally
> enabled across all CPUs. This patch also adds an informational message
> when HWP is disabled via intel_pstate=no_hwp.
> 
> Cc: Kristen Carlson Accardi <kristen@linux.intel.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>

Applied, thanks!

Rafael

