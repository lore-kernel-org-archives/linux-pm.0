From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 06/26] thermal: cpu_cooling: fix doc comment over
 struct cpufreq_cooling_device
Date: Thu, 4 Dec 2014 16:06:11 +0530
Message-ID: <CAKohpomtF8ZLty-oyUccc0BoANviopLgDOXH9oKXNo4WC96RiA@mail.gmail.com>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
	<65fe28eb30ff75ec96c29f85c0822eecf23879bf.1417664938.git.viresh.kumar@linaro.org>
	<20141204103213.GB22781@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:57718 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753686AbaLDKgM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Dec 2014 05:36:12 -0500
Received: by mail-oi0-f43.google.com with SMTP id a3so12158543oib.2
        for <linux-pm@vger.kernel.org>; Thu, 04 Dec 2014 02:36:11 -0800 (PST)
In-Reply-To: <20141204103213.GB22781@e104805>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "amit.daniel@samsung.com" <amit.daniel@samsung.com>

On 4 December 2014 at 16:02, Javi Merino <javi.merino@arm.com> wrote:
> Instead of deleting this comment, move it to where it belongs.  From
> my understanding, the cooling_cpufreq_lock protects the
> cpufreq_dev_list.  Can you move the comment there?

I will add a separate patch to add comment over cooling_cpufreq_lock
to define what all it protects.

Thanks.
