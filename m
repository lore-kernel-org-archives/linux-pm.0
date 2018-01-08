From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [BUG] s2idle: Surface Pro 3 suspend/resume issues
Date: Mon, 08 Jan 2018 16:13:44 +0800
Message-ID: <1515399224.2578.17.camel@intel.com>
References: <85be1584-5260-e7e1-2eda-23607f5a93c2@mrs.ro>
         <d1c1bab6e2b343abf9105a892dc06c49@mrs.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:18775 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754998AbeAHINs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jan 2018 03:13:48 -0500
In-Reply-To: <d1c1bab6e2b343abf9105a892dc06c49@mrs.ro>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Valentin Manea <valy@mrs.ro>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Mon, 2018-01-08 at 07:55 +0000, Valentin Manea wrote:
> Again with correct linux-pm
> 
> Hi,
> 
>    Somewhere between 4.12 and 4.13 the s2idle doesn't work anymore on
> the
> Surface Pro 3.

will you please be more specific about the symptom?
what command do you use to do s2idle, and how do you wake it up?


BTW, does the problem still exists in the latest upstream kernel?

thanks,
rui
>    After some bisecting I found 3 patches that seem to be at fault
> ACPI / sleep: EC-based wakeup from suspend-to-idle on recent systems
> ->
> 0f1a83833a0ba93d6986d9e30c8fe35d7d45c17c
> 
> ACPI / PM: Ignore spurious SCI wakeups from suspend-to-idle ->
> 33e4f80ee69b5168badf37edbfed796eb48434b9
> 
> ACPI / PM: Clean up device wakeup enable/disable code ->
> 235d81a630ca2d39818da96f0c14bc960ffbaeb5
> 
>    It doesn't seem to be just one patch, I've tried combinations of
> the
> 3, but only with all three reverted s2idle suspend and resume starts
> working again.
>    I'm not versed in x86 and ACPI so my testing is very coarse
> because
> there is some re-factoring included there. Do you have any idea which
> parts could be casing the problem? Or at least how to debug further?
> 
> Thanks,
> Valentin
