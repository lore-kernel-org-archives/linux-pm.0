From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/11] CPUFreq Kconfig fixes
Date: Wed, 12 Jun 2013 14:46:59 +0200
Message-ID: <201306121447.00139.arnd@arndb.de>
References: <cover.1371022830.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:56898 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402Ab3FLMrI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jun 2013 08:47:08 -0400
In-Reply-To: <cover.1371022830.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com

On Wednesday 12 June 2013, Viresh Kumar wrote:
> Recently Arnd sent few fixes where drivers were using APIs from freq_table.c but
> haven't selected CPU_FREQ_TABLE. Based on that, I just crossed checked all the
> places where it should be selected and where it shouldn't be. These are fixes
> around that.
> 
> I have applied these in my cpufreq-kconfig-fixes branch. Will send you a pull
> request separately once I get some Acks (will wait for few days).

Acked-by: Arnd Bergmann <arnd@arndb.de>

I don't see a patch for big.LITTLE in either linux-next or this series. Did you
miss that or has it just not made into linux-next yet?

	Arnd
