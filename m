From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 0/2] cpufreq: cpu0: Improvements for cpu0_set_target()
Date: Mon, 06 Oct 2014 08:16:19 +0200
Message-ID: <543233B3.1040502@i2se.com>
References: <1412454365-17804-1-git-send-email-stefan.wahren@i2se.com> <3655188.0cIJZFUFYF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:52341 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbaJFGQd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Oct 2014 02:16:33 -0400
In-Reply-To: <3655188.0cIJZFUFYF@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, shawn.guo@freescale.com

Am 05.10.2014 um 23:34 schrieb Rafael J. Wysocki:
> On Saturday, October 04, 2014 08:26:02 PM Stefan Wahren wrote:
>> This patch series contains 2 improvements for cpu0_set_target().
>>
>> Stefan Wahren (2):
>>   cpufreq: cpu0: Improve debug about matching OPP
>>   cpufreq: cpu0: Handle regulator_get_voltage() failure
>>
>>  drivers/cpufreq/cpufreq-cpu0.c |    9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
> We renamed cpufreq-cpu0 to cpufreq-dt in the meantime.
>

I will fix that.

Stefan
