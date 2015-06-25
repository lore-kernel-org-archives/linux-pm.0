From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH] tick/idle/powerpc: Do not register idle states with CPUIDLE_FLAG_TIMER_STOP
 set in periodic mode
Date: Thu, 25 Jun 2015 09:05:49 +0530
Message-ID: <558B7715.1060802@linux.vnet.ibm.com>
References: <20150624064801.30680.3246.stgit@perfhull-ltc.austin.ibm.com> <1700583.a34yOllUuC@vostro.rjw.lan> <1435183570.3790.15.camel@kernel.crashing.org> <CAJZ5v0hiKVN7Nvc4w3BP9uWmvdUkX6T+DUGh6OSZWPTrpwcyjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:52757 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbbFYDgM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2015 23:36:12 -0400
Received: from /spool/local
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Wed, 24 Jun 2015 21:36:11 -0600
In-Reply-To: <CAJZ5v0hiKVN7Nvc4w3BP9uWmvdUkX6T+DUGh6OSZWPTrpwcyjA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, shreyas@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org

On 06/25/2015 05:36 AM, Rafael J. Wysocki wrote:
> On Thu, Jun 25, 2015 at 12:06 AM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
>> On Wed, 2015-06-24 at 15:50 +0200, Rafael J. Wysocki wrote:
>>> 4.2 material I suppose?
>>
>> And stable. Without this, if you configure without TICK_ONESHOT, the
>> machine will hang.
> 
> OK, which -stable?  All of them or any specific series?

This needs to go into stable/linux-3.19.y,
stable/linux-4.0.y, stable/linux-4.1.y.

Thanks

Regards
Preeti U Murthy
> 
> Rafael
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 

