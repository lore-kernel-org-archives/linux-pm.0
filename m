From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 00/14] cpufreq: resource management in preparation for
 module build
Date: Wed, 4 Feb 2015 15:26:46 +0530
Message-ID: <CAKohpomJC2n94MGAywUYesYP8bOPE87gqNTTUGUhDBsR_mnL9Q@mail.gmail.com>
References: <1422910697-5920-1-git-send-email-edubezval@gmail.com>
	<20150204095244.25a56a0a@amdc2363>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:50131 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965030AbbBDJ4r (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Feb 2015 04:56:47 -0500
Received: by mail-ob0-f178.google.com with SMTP id uz6so497499obc.9
        for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2015 01:56:46 -0800 (PST)
In-Reply-To: <20150204095244.25a56a0a@amdc2363>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Linux PM <linux-pm@vger.kernel.org>

On 4 February 2015 at 14:22, Lukasz Majewski <l.majewski@samsung.com> wrote:
> And one more thought - why (as of 3.19.0-rc5) there is no tri state on
> CONFIG_CPU_FREQ? Is there any ongoing work to provide this?

There is no requirement for the framework to be compilable as module.
