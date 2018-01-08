From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [BUG] function_graph trace causes  hang when using sleepgraph
 (4.15.0-rc1 and newer)
Date: Mon, 08 Jan 2018 15:55:14 -0800
Message-ID: <1515455714.17761.7.camel@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:15807 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757008AbeAHXzQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jan 2018 18:55:16 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, rostedt@goodmis.org, linux-pm@vger.kernel.org
Cc: len.brown@intel.com, todd.e.brandt@intel.com

I've discovered an issue in the kernel which is causing sleepgraph
(analyse_suspend) to hang the system when it tries to get a callgraph
trace over suspend/resume. It happens on kernels 4.15.0-rc1 and newer.

I've whittled it down to 3 items which have to be set for the hang to
occur:

1) enable function_graph trace
2) enable global clock
3) enable trace points device_pm_callback_start or
device_pm_callback_end

These things all occur when sleepgraph is run with -f. It needs to
collect a function graph trace with global clock in tandem with the the
device_pm_callback trace events. 

This script reproduces the error:

echo "global" > /sys/kernel/debug/tracing/trace_clock
echo "function_graph" > /sys/kernel/debug/tracing/current_tracer
echo 1 >
/sys/kernel/debug/tracing/events/power/device_pm_callback_start/enable
echo 1 >
/sys/kernel/debug/tracing/events/power/device_pm_callback_end/enable
echo 1 >  /sys/kernel/debug/tracing/tracing_on
echo "mem" > /sys/power/state
# hang occurs here: system has to be rebooted
echo 0 >  /sys/kernel/debug/tracing/tracing_on

I performed a bisect between 4.14.0 and 4.15.0-rc1 and it landed on an
ftrace patch that was merged in for 4.15.0-rc1. I'm still debugging it,
but I just wanted to get this out there ASAP so it can be hopefully be
fixed before 4.15.0. I'm not sure if the issue is in ftrace or in the
pm subsystem device_pm_callback code (though nothing has changed in the
latter).

-- [BISECT LOG START] --

git bisect start
# bad: [4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323] Linux 4.15-rc1
git bisect bad 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323
# good: [bebc6082da0a9f5d47a1ea2edc099bf671058bd4] Linux 4.14
git bisect good bebc6082da0a9f5d47a1ea2edc099bf671058bd4
# good: [1be2172e96e33bfa22a5c7a651f768ef30ce3984] Merge tag 'modules-
for-v4.15' of git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux
git bisect good 1be2172e96e33bfa22a5c7a651f768ef30ce3984
# good: [8c609698569578913ad40bb160b97c3f6cfa15ec] Merge tag 'armsoc-
soc' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
git bisect good 8c609698569578913ad40bb160b97c3f6cfa15ec
# good: [f6705bf959efac87bca76d40050d342f1d212587] Merge tag 'drm-for-
v4.15-amd-dc' of git://people.freedesktop.org/~airlied/linux
git bisect good f6705bf959efac87bca76d40050d342f1d212587
# bad: [c633e898bde8990a34907c91b7d5245cab866c6e] Merge tag
'devicetree-fixes-for-4.15' of
git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
git bisect bad c633e898bde8990a34907c91b7d5245cab866c6e
# bad: [fc35c1966e1372a21a88f6655279361e2f92713f] Merge tag 'clk-for-
linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
git bisect bad fc35c1966e1372a21a88f6655279361e2f92713f
# bad: [09bd7c75e55cbaa6c731b0c3a5512ad89159f26f] Merge tag 'kbuild-
v4.15' of
git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
git bisect bad 09bd7c75e55cbaa6c731b0c3a5512ad89159f26f
# good: [5eb9e8ac9a8f8ae98ae4386357683a0b5684bb48]
arch/ia64/include/asm/topology.h: remove unused parent_node() macro
git bisect good 5eb9e8ac9a8f8ae98ae4386357683a0b5684bb48
# bad: [2dcd9c71c1ffa9a036e09047f60e08383bb0abb6] Merge tag 'trace-
v4.15' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-
trace
git bisect bad 2dcd9c71c1ffa9a036e09047f60e08383bb0abb6
# bad: [466c81c45b650deca213fda3d0ec4761667379a9] perf/ftrace: Fix
function trace events
git bisect bad 466c81c45b650deca213fda3d0ec4761667379a9
# bad: [3e234289f86b12985ef8909cd34525fcb66c4efb] ftrace: Allow module
init functions to be traced
git bisect bad 3e234289f86b12985ef8909cd34525fcb66c4efb
# bad: [83c07ecc4203728e85fc4a2ce6fdf25d16ea118e] tracing: Remove
lookups from tracing_map hitcount
git bisect bad 83c07ecc4203728e85fc4a2ce6fdf25d16ea118e
# bad: [12ecef0cb12102d8c034770173d2d1363cb97d52] tracing: Reverse the
order of trace_types_lock and event_mutex
git bisect bad 12ecef0cb12102d8c034770173d2d1363cb97d52
# good: [6e7a2398114a2597a0995f96f44d908741ae5035] tracing: Remove
redundant unread variable ret
git bisect good 6e7a2398114a2597a0995f96f44d908741ae5035
# first bad commit: [12ecef0cb12102d8c034770173d2d1363cb97d52] tracing:
Reverse the order of trace_types_lock and event_mutex

-- [BISECT LOG END] --

This is the commit it landed on.

12ecef0cb12102d8c034770173d2d1363cb97d52 is the first bad commit
commit 12ecef0cb12102d8c034770173d2d1363cb97d52
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Thu Sep 21 16:22:49 2017 -0400

    tracing: Reverse the order of trace_types_lock and event_mutex
    
    In order to make future changes where we need to call
    tracing_set_clock() from within an event command, the order of
    trace_types_lock and event_mutex must be reversed, as the event
command
    will hold event_mutex and the trace_types_lock is taken from within
    tracing_set_clock().
    
    Link: http://lkml.kernel.org/r/20170921162249.0dde3dca@gandalf.loca
l.home
    
    Requested-by: Tom Zanussi <tom.zanussi@linux.intel.com>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
