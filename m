From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RESEND PATCH] cpupower: Do not change the frequency of offline cpu
Date: Thu, 23 Jul 2015 22:58:38 +0200
Message-ID: <1838455.HBmItYYPC0@vostro.rjw.lan>
References: <1437553249-25400-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <1437634227-12555-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56890 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753544AbbGWUbu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2015 16:31:50 -0400
In-Reply-To: <1437634227-12555-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: rafael.j.wysocki@intel.com, trenn@suse.com, ego@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday, July 23, 2015 12:20:27 PM Shilpasri G Bhat wrote:
> Check if the cpu is online before changing the frequency/governor of
> the cpu.
> 
> Reported-by: Pavaman Subramaniyam <pavsubra@linux.vnet.ibm.com>
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Acked-by: Thomas Renninger <trenn@suse.com>

Queued up for 4.3, thanks!

Rafael

