From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] intel_pstate: Update cpu_frequency tracepoint every time
Date: Tue, 19 Jul 2016 20:14:53 -0700
Message-ID: <001a01d1e234$e33ce290$a9b6a7b0$@net>
References: <3678564.0E838ntcHL@vostro.rjw.lan> <1468967958.2125.2.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1468967958.2125.2.camel@linux.intel.com>
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Linux PM list' <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2016.07.19 15:10 Srinivas Pandruvada wrote:
> On Tue, 2016-07-19 at 15:10 +0200, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> 
>> Currently, intel_pstate only updates the cpu_frequency tracepoint
>> if the new P-state to set is different from the current one, but
>> that causes powertop to report 100% idle on an 100% loaded system
>> sometimes.
>> 
>> Prevent that from happening by updating the cpu_frequency tracepoint
>> every time intel_pstate_update_pstate() is called.
>> 
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>-

Shouldn't this patch refer to:

commit fdfdb2b1301670a69195ba1e5666df4a7f02eb46
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Fri Mar 18 23:20:02 2016 +0100

    intel_pstate: Do not call wrmsrl_on_cpu() with disabled interrupts

which is the patch that introduced the regression?

... Doug
