From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] tick/idle/powerpc: Do not register idle states with
 CPUIDLE_FLAG_TIMER_STOP set in periodic mode
Date: Thu, 25 Jun 2015 08:06:10 +1000
Message-ID: <1435183570.3790.15.camel@kernel.crashing.org>
References: <20150624064801.30680.3246.stgit@perfhull-ltc.austin.ibm.com>
	 <1700583.a34yOllUuC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:43489 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751815AbbFXXrA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 24 Jun 2015 19:47:00 -0400
In-Reply-To: <1700583.a34yOllUuC@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>, daniel.lezcano@linaro.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, linux-pm@vger.kernel.org, mpe@ellerman.id.au, will.deacon@arm.com, linux-kernel@vger.kernel.org, shreyas@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org

On Wed, 2015-06-24 at 15:50 +0200, Rafael J. Wysocki wrote:
> 4.2 material I suppose?

And stable. Without this, if you configure without TICK_ONESHOT, the
machine will hang.

Cheers,
Ben.


