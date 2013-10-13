From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 2/2] ARM: at91: cpuidle: Move driver to drivers/cpuidle
Date: Sun, 13 Oct 2013 11:19:45 +0200
Message-ID: <20131013111945.0251a3cc@skate>
References: <1381593099-1184-1-git-send-email-daniel.lezcano@linaro.org>
	<1381593099-1184-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:56525 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753816Ab3JMJUA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 13 Oct 2013 05:20:00 -0400
In-Reply-To: <1381593099-1184-2-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

Dear Daniel Lezcano,

On Sat, 12 Oct 2013 17:51:39 +0200, Daniel Lezcano wrote:

> +config ARM_AT91_CPUIDLE
> +        bool "Cpu Idle Driver for the AT91 processors"

Nitpick: indentation is done with spaces here, while it should be one
tab.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
