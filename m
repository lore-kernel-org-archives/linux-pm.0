From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 09/16] ARM: mvebu: Make the snoop disable optional in
 mvebu_v7_pmsu_idle_prepare
Date: Thu, 3 Jul 2014 14:55:14 +0200
Message-ID: <20140703145514.65addd5a@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
	<1403875377-940-10-git-send-email-gregory.clement@free-electrons.com>
	<20140630174338.13604523@free-electrons.com>
	<53B5518E.3050702@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:50166 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756013AbaGCMzT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jul 2014 08:55:19 -0400
In-Reply-To: <53B5518E.3050702@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Dear Gregory CLEMENT,

On Thu, 03 Jul 2014 14:50:22 +0200, Gregory CLEMENT wrote:

> Maybe we can use flags, hence we use only one arguments, it became extensible,
> and more readable too. Something like
> 
> #define PMSU_IDLE_NO_FLAG 0
> #define PMSU_IDLE_DEEPIDLE BIT(0)
> #define PMSU_IDLE_SNOOPDIS BIT(1)
> 
> then we can have:
> mvebu_v7_pmsu_idle_prepare(PMSU_IDLE_SNOOPDIS);
> mvebu_v7_pmsu_idle_prepare(PMSU_IDLE_DEEPIDLE | PMSU_IDLE_SNOOPDIS);
> mvebu_v7_pmsu_idle_prepare(PMSU_IDLE_NO_FLAG);
> 
> static void mvebu_v7_pmsu_idle_prepare(u32 flags)

Yes, seems a good idea to me. Used "unsigned int" as the type for the
flags argument, and maybe use PMSU_IDLE_NORMAL for 0 instead of NO_FLAG.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
