From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 08/26] cpu_cooling: Pass variable instead of its type to sizeof()
Date: Wed, 3 Dec 2014 10:08:08 +0530
Message-ID: <CAKohpom=Tp5B5f4B6PjsFxpyU_Kgu_D=uo9n0ypLSA-RR2ck3w@mail.gmail.com>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
	<1a0d2430eb52b55fdb8f82c4cbbb8b4038a105ec.1417167599.git.viresh.kumar@linaro.org>
	<20141202152624.GA2834@e104805>
	<20141202230730.GC3432@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:40490 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbaLCEiJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Dec 2014 23:38:09 -0500
Received: by mail-ob0-f171.google.com with SMTP id uz6so10954811obc.30
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2014 20:38:09 -0800 (PST)
In-Reply-To: <20141202230730.GC3432@developer>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Javi Merino <javi.merino@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>

On 3 December 2014 at 04:37, Eduardo Valentin <edubezval@gmail.com> wrote:
>> This should be:
>>
>> +     cpufreq_dev = kzalloc(sizeof(*cpufreq_dev), GFP_KERNEL);

This is insulting now. So stupid mistake..
