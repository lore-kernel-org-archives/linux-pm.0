From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH v2] cpufreq: kirkwood-cpufreq:- Handle return value of
 clk_prepare_enable
Date: Wed, 17 May 2017 12:19:13 +0530
Message-ID: <919e260e-01d5-1bc0-233d-70db19fbcdcd@gmail.com>
References: <1495003358-25593-1-git-send-email-arvind.yadav.cs@gmail.com>
 <20170517064549.GC17481@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34844 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751005AbdEQGu0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 May 2017 02:50:26 -0400
In-Reply-To: <20170517064549.GC17481@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Sorry, I missed it. Now I am going to add.

Thanks
-Arvind


On Wednesday 17 May 2017 12:15 PM, Viresh Kumar wrote:
> On 17-05-17, 12:12, Arvind Yadav wrote:
>> Here, Clock enable can failed. So adding an error check for
>> clk_prepare_enable.
> You missed my comment for the commit log.
>
