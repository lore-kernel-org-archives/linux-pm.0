From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 16/26] cpu_cooling: Drop useless locking around idr_alloc/idr_remove
Date: Wed, 3 Dec 2014 15:02:51 +0530
Message-ID: <CAKohpomTB8yaSUAHjmPMJg6oKXVcAX1YsHvBYJa5x6iAtkqMCg@mail.gmail.com>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
	<a71abc2219d80e9b8e77599d2e60612a96bb36a9.1417167599.git.viresh.kumar@linaro.org>
	<20141202230533.GB3432@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:55885 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366AbaLCJcw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 04:32:52 -0500
Received: by mail-ob0-f171.google.com with SMTP id uz6so11163983obc.2
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2014 01:32:51 -0800 (PST)
In-Reply-To: <20141202230533.GB3432@developer>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Zhang Rui <rui.zhang@intel.com>

On 3 December 2014 at 04:35, Eduardo Valentin <edubezval@gmail.com> wrote:
> On Fri, Nov 28, 2014 at 03:14:10PM +0530, Viresh Kumar wrote:
>> Locking around idr_alloc/idr_remove looks rather pointless as there is no race
>> it is trying to fix. Remove it.
>>
>
> Can you please elaborate on how the idr's are going to be serialize
> without the lock?

Dropped this patch, I was wrong ..
