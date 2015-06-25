From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] tick/idle/powerpc: Do not register idle states with
 CPUIDLE_FLAG_TIMER_STOP set in periodic mode
Date: Thu, 25 Jun 2015 02:06:32 +0200
Message-ID: <CAJZ5v0hiKVN7Nvc4w3BP9uWmvdUkX6T+DUGh6OSZWPTrpwcyjA@mail.gmail.com>
References: <20150624064801.30680.3246.stgit@perfhull-ltc.austin.ibm.com>
	<1700583.a34yOllUuC@vostro.rjw.lan>
	<1435183570.3790.15.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35997 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbbFYAGd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2015 20:06:33 -0400
In-Reply-To: <1435183570.3790.15.camel@kernel.crashing.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, mpe@ellerman.id.au, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, shreyas@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org

On Thu, Jun 25, 2015 at 12:06 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2015-06-24 at 15:50 +0200, Rafael J. Wysocki wrote:
>> 4.2 material I suppose?
>
> And stable. Without this, if you configure without TICK_ONESHOT, the
> machine will hang.

OK, which -stable?  All of them or any specific series?

Rafael
