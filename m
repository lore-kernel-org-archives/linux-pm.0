From: Valentin Manea <valy@mrs.ro>
Subject: [BUG] s2idle: Surface Pro 3 suspend/resume issues
Date: Mon, 08 Jan 2018 07:55:48 +0000
Message-ID: <d1c1bab6e2b343abf9105a892dc06c49@mrs.ro>
References: <85be1584-5260-e7e1-2eda-23607f5a93c2@mrs.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mrs.ro ([109.74.194.28]:43412 "EHLO mrs.ro"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755868AbeAHID0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jan 2018 03:03:26 -0500
In-Reply-To: <85be1584-5260-e7e1-2eda-23607f5a93c2@mrs.ro>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Again with correct linux-pm

Hi,

   Somewhere between 4.12 and 4.13 the s2idle doesn't work anymore on the
Surface Pro 3.
   After some bisecting I found 3 patches that seem to be at fault
ACPI / sleep: EC-based wakeup from suspend-to-idle on recent systems ->
0f1a83833a0ba93d6986d9e30c8fe35d7d45c17c

ACPI / PM: Ignore spurious SCI wakeups from suspend-to-idle ->
33e4f80ee69b5168badf37edbfed796eb48434b9

ACPI / PM: Clean up device wakeup enable/disable code ->
235d81a630ca2d39818da96f0c14bc960ffbaeb5

   It doesn't seem to be just one patch, I've tried combinations of the
3, but only with all three reverted s2idle suspend and resume starts
working again.
   I'm not versed in x86 and ACPI so my testing is very coarse because
there is some re-factoring included there. Do you have any idea which
parts could be casing the problem? Or at least how to debug further?

Thanks,
Valentin
