From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 1/1] PM / OPP: Fix get sharing cpus when hotplug is used
Date: Mon, 31 Jul 2017 20:50:15 +0200
Message-ID: <CAJZ5v0jgU0tLQwz=rNZbU3jaRhz3J31zv5HwhZ4L=og7EErQAQ@mail.gmail.com>
References: <201707302248.x4bqfCKB%fengguang.wu@intel.com> <1881043.tatm6HIeku@aspire.rjw.lan>
 <CAHKzcEPQw=_mMr2-5TgU7FiPKvYfeHNCV=LjjKwEV1==y47y9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:33030 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751563AbdGaSuQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Jul 2017 14:50:16 -0400
Received: by mail-it0-f67.google.com with SMTP id m34so1250588iti.0
        for <linux-pm@vger.kernel.org>; Mon, 31 Jul 2017 11:50:16 -0700 (PDT)
In-Reply-To: <CAHKzcEPQw=_mMr2-5TgU7FiPKvYfeHNCV=LjjKwEV1==y47y9g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>, kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>

On Mon, Jul 31, 2017 at 5:12 PM, Waldemar Rymarkiewicz
<waldemar.rymarkiewicz@gmail.com> wrote:
> On 31 July 2017 at 13:14, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Sunday, July 30, 2017 10:54:30 PM kbuild test robot wrote:
>>> Hi Waldemar,
>>>
>>> [auto build test ERROR on pm/linux-next]
>>> [also build test ERROR on v4.13-rc2 next-20170728]
>>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> OK, I'm dropping this commit.
>>
>> Please make sure that the problem is fixed before sending a new version of it.
>
> I am a bit confused, it was already fixed and sent out in v5 [1], but
> I see v5 is in 'Not Applicable, archived' state. Why?
>
> [1] https://patchwork.kernel.org/patch/9866525/

Because it was applied and still broke.

Thanks,
Rafael
