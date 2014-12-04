From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 25/26] thermal: cpu_cooling: Use cpufreq_dev->freq_table
 for finding level/freq
Date: Thu, 4 Dec 2014 16:26:51 +0530
Message-ID: <CAKohpoktEFac60Su2OwmXiicr5YAPhhZNNnNs=Csinhw+4sBsg@mail.gmail.com>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
	<45a3ff79a10b0618783f0043efa44966c758b410.1417664938.git.viresh.kumar@linaro.org>
	<20141204105240.GC22781@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:50883 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420AbaLDK4w (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Dec 2014 05:56:52 -0500
Received: by mail-oi0-f53.google.com with SMTP id x69so12207867oia.40
        for <linux-pm@vger.kernel.org>; Thu, 04 Dec 2014 02:56:52 -0800 (PST)
In-Reply-To: <20141204105240.GC22781@e104805>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>, Joe Perches <joe@perches.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "amit.daniel@samsung.com" <amit.daniel@samsung.com>

On 4 December 2014 at 16:22, Javi Merino <javi.merino@arm.com> wrote:
>> - * Return: 0 on success, -EINVAL when invalid parameters are passed.
>> + * Returns: level on success, THERMAL_CSTATE_INVALID on error.
>
> Should be "Return:", as it was.  See Documentation/kernel-doc-nano-HOWTO.txt

I have seen such comment earlier and my bad for not keeping a note of that.
Probably we need a checkpatch warning for this :)

Will resend this one. Thanks for your reviews Javi.
