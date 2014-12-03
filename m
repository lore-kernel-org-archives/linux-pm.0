From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 24/26] cpu_cooling: Store frequencies in descending order
Date: Wed, 3 Dec 2014 10:22:30 +0530
Message-ID: <CAKohpo=ew8wUeJ4Mf567BNP70AS8uHDWmBEFzL4Uo_ze0UtJ+A@mail.gmail.com>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
	<ecb90bfbe1dd69ad73210630ce0a2f988d6210f1.1417167599.git.viresh.kumar@linaro.org>
	<20141202232128.GA3645@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57375 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077AbaLCEwb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Dec 2014 23:52:31 -0500
Received: by mail-ob0-f174.google.com with SMTP id nt9so4000719obb.19
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2014 20:52:30 -0800 (PST)
In-Reply-To: <20141202232128.GA3645@developer>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Zhang Rui <rui.zhang@intel.com>

On 3 December 2014 at 04:51, Eduardo Valentin <edubezval@gmail.com> wrote:

>> +static unsigned int find_next_max(struct cpufreq_frequency_table *table,
>> +                               unsigned int prev_max)
>> +{
>> +     struct cpufreq_frequency_table *pos;
>> +     unsigned int max = 0;
>> +
>> +     cpufreq_for_each_valid_entry(pos, table) {
>> +             if (pos->frequency > max && pos->frequency < prev_max)
>
> What happens if, for some random reason, the cpufreq table is in
> ascending order and this function is called with prev_max == (unsigned
> int) -1 ? What would be the returned max?

The last frequency of the table, i.e. the max value. What bug did you catch,
that I am not able to see..
