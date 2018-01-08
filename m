From: Valentin Manea <linux-pm@mrs.ro>
Subject: Re: [BUG] s2idle: Surface Pro 3 suspend/resume issues
Date: Mon, 08 Jan 2018 09:37:21 +0000
Message-ID: <3d66f6cc685b3f56817819b600ea2de2@mrs.ro>
References: <85be1584-5260-e7e1-2eda-23607f5a93c2@mrs.ro>
 <d1c1bab6e2b343abf9105a892dc06c49@mrs.ro>
 <1515399224.2578.17.camel@intel.com>
 <f9aed3f0e77fc7d3f663fb913e1bb5aa@mrs.ro>
 <1515400670.2578.18.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mrs.ro ([109.74.194.28]:43838 "EHLO mrs.ro"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756331AbeAHJhW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jan 2018 04:37:22 -0500
In-Reply-To: <1515400670.2578.18.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On 2018-01-08 08:37, Zhang Rui wrote:
> On Mon, 2018-01-08 at 08:21 +0000, Valentin Manea wrote:
>> On 2018-01-08 08:13, Zhang Rui wrote:
> 
> in latest upstream kernel, does it work if you use rtcwake instead?
> say, "rtcwake -m freeze -s 20"
Sorry didn't try rtcwake but when I try 
pm_test(platform,devices,freezer) with almost any value the system goes 
to sleep/resumes fine. I will give rtcwake a try later today and let you 
know of the results.

Thanks,
Valentin
