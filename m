From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: Re: [BUG] function_graph trace causes  hang when using sleepgraph
 (4.15.0-rc1 and newer)
Date: Wed, 10 Jan 2018 16:21:08 -0800
Message-ID: <1515630068.17761.16.camel@linux.intel.com>
References: <1515455714.17761.7.camel@linux.intel.com>
         <1515459749.17761.10.camel@linux.intel.com>
         <20180108200756.08712bb4@vmware.local.home>
         <1515461115.17761.12.camel@linux.intel.com>
         <20180109111334.2628dcc5@vmware.local.home>
Reply-To: todd.e.brandt@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:20956 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752473AbeAKAVK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Jan 2018 19:21:10 -0500
In-Reply-To: <20180109111334.2628dcc5@vmware.local.home>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, len.brown@intel.com, todd.e.brandt@intel.com

On Tue, 2018-01-09 at 11:13 -0500, Steven Rostedt wrote:
> On Mon, 08 Jan 2018 17:25:15 -0800
> Todd Brandt <todd.e.brandt@linux.intel.com> wrote:
> 
> > Can you reproduce the issue there? I just want to be sure it's not
> > something local to our machines here, as long as you have CONFIG_PM
> > enabled it should work the same hopefully. 
> 
> Just to let you know, I'm currently traveling, so my testing ability
> is
> limited at the time being.

ok, it's not an emergency, we're using a patched version of the kernel
with those two commits removed in the interim. I tried running kgdb
over serial console, but unfortunately it doesn't work over a USB-to-
Serial dongle (even Greg K-H says it won't work, :P). This is the best
output I could get, considering:

# run the test script here
[  545.733458] PM: suspend entry (deep)
[  545.734535] PM: Syncing filesystems ... done.
[  546.580551] Freezing user space processes ... (elapsed 0.013
seconds) done.
[  546.594846] OOM killer disabled.
[  546.595002] Freezing remaining freezable tasks ... (elapsed 0.005
seconds) done.
[  557.808719] NMI watchdog: Watchdog detected hard LOCKUP on cpu 0

So it's definitely a hard lockup, I just can't get the stack trace
without a system with a built in serial console.

> 
> -- Steve
