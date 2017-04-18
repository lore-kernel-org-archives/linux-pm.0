From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [RESEND PATCH] tools/power/x86/intel_pstate_tracer: Adjust directory permissions
Date: Mon, 17 Apr 2017 17:11:57 -0700
Message-ID: <001801d2b7d8$662b7a30$32826e90$@net>
References: <1492355834-7793-1-git-send-email-dsmythies@telus.net> zt6UczvfGopZnzt6WcBT3m
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta19.telus.net ([209.171.16.92]:52955 "EHLO cmta19.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751852AbdDRAMD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Apr 2017 20:12:03 -0400
In-Reply-To: zt6UczvfGopZnzt6WcBT3m
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Len Brown' <len.brown@intel.com>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Linux PM' <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>

On 2107.04.16 15:57 Rafael J. Wysocki wrote:
> On Sun, Apr 16, 2017 at 5:17 PM, Doug Smythies <doug.smythies@gmail.com> wrote:
>> Depending on what is being done, the intel_pstate_tracer.py script
>> needs to be run as root, or can be run as a regular user.
>> If run the first time as root the results directory will be
>> incorrect for any subsequent run as a regular user.
>
> Which is OK.
>
> For security reasons, non-root should not be able to modify root-owned
> directories.

Hi Rafael,

I do not see a security issue here.

The objective was to merge what used to be
two steps (with the old, never released, post processing tools)
into one step. The only reason "root" was ever needed was for
the actual trace step. In the past everything else could be
done as a regular user. Even when the two step method is used
and we are processing a previously acquired (as "root"), it is
preferred to do so as a regular user.

Anyway, in a minute I will send a version 2 of the patch, where
the user and group IDs are changed to regular user, rather than
changing permissions.

... Doug
