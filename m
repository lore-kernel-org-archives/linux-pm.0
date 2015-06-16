From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH v2] drivers/cpufreq: Convert non-modular s5pv210-cpufreq.c
 to use builtin_platform_driver
Date: Tue, 16 Jun 2015 11:37:27 -0400
Message-ID: <558042B7.5090409@windriver.com>
References: <20150512070444.GE32300@linux> <1433365966-29850-1-git-send-email-paul.gortmaker@windriver.com> <2052041.toNogcAkWs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:46114 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033AbbFPPhz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jun 2015 11:37:55 -0400
In-Reply-To: <2052041.toNogcAkWs@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org

On 15-06-15 07:50 PM, Rafael J. Wysocki wrote:
> On Wednesday, June 03, 2015 05:12:46 PM Paul Gortmaker wrote:
>> This file depends on a Kconfig option which is a bool, so
>> we use the appropriate registration function, which avoids us
>> relying on an implicit inclusion of <module.h> which we are
>> doing currently.
>>
>> While this currently works, we really don't want to be including
>> the module.h header in non-modular code, which we'd be forced
>> to do, pending some upcoming code relocation from init.h into
>> module.h.  So we fix it now by using the non-modular equivalent.
>>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: Kukjin Kim <kgene@kernel.org>
>> Cc: linux-pm@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> I'm assuming that this will go in via the Samsung tree.

Per other patch, I'll have to keep a copy in my branch to
avoid introducing bisect compile fails into the git history.

Thanks,
Paul.


> 
> 
