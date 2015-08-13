From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [Linaro-acpi] [PATCH 1/5] ACPI: add in a bad_madt_entry() function
 to eventually replace the macro
Date: Thu, 13 Aug 2015 17:30:36 +0800
Message-ID: <55CC63BC.4080902@linaro.org>
References: <1438894770-31163-1-git-send-email-al.stone@linaro.org>	<1438894770-31163-2-git-send-email-al.stone@linaro.org> <CAOZdJXVZomskfpvEjmDUiptW3SndJWvfKyzd9SwJp3dh7h3pig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36033 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052AbbHMJao (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2015 05:30:44 -0400
Received: by pacrr5 with SMTP id rr5so34262107pac.3
        for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2015 02:30:44 -0700 (PDT)
In-Reply-To: <CAOZdJXVZomskfpvEjmDUiptW3SndJWvfKyzd9SwJp3dh7h3pig@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>, Al Stone <al.stone@linaro.org>
Cc: linux-acpi@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linaro-kernel@lists.linaro.org, linux-ia64@vger.kernel.org, patches@linaro.org, linux-pm@vger.kernel.org, linaro-acpi@lists.linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, lkml <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>

On 08/13/2015 06:35 AM, Timur Tabi wrote:
> On Thu, Aug 6, 2015 at 3:59 PM, Al Stone <al.stone@linaro.org> wrote:
>> +       while (ms->num_types != 0) {
>> +               if (ms->major_version == major &&
>> +                   ms->minor_version == minor &&
>> +                   ms->madt_version == madt->header.revision)
>> +                       break;
>> +               ms++;
>> +       }
>> +       if (!ms) {
>
> Shouldn't this be
>
>    if (!ms->num_types) {
>
> instead?

I think so, but seems nothing to do with the FADT version,
Al may explain more about it :)

Thanks
Hanjun
