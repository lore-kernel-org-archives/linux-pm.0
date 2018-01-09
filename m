From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [BUG] function_graph trace causes  hang when using sleepgraph
 (4.15.0-rc1 and newer)
Date: Mon, 8 Jan 2018 20:07:56 -0500
Message-ID: <20180108200756.08712bb4@vmware.local.home>
References: <1515455714.17761.7.camel@linux.intel.com>
        <1515459749.17761.10.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756071AbeAIBH6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jan 2018 20:07:58 -0500
In-Reply-To: <1515459749.17761.10.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Todd Brandt <todd.e.brandt@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, len.brown@intel.com, todd.e.brandt@intel.com

On Mon, 08 Jan 2018 17:02:29 -0800
Todd Brandt <todd.e.brandt@linux.intel.com> wrote:

> Stephen, the problem is reversed by removing the following two commits,
> the one the bisect showed and the very next. So the problem is here:
> 
> commit 1a149d7d3f45d311da1f63473736c05f30ae8a75
> Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Date:   Fri Sep 22 16:59:02 2017 -0400
> 
>     ring-buffer: Rewrite trace_recursive_(un)lock() to be simpler

This one still doesn't make sense, for why it would cause the hang.


> commit 12ecef0cb12102d8c034770173d2d1363cb97d52
> Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Date:   Thu Sep 21 16:22:49 2017 -0400
> 
>     tracing: Reverse the order of trace_types_lock and event_mutex

This one does.

Can you run lockdep when you do this and see if lockdep catches
anything? If it does, it should point directly to where the inversed
locking happened.

-- Steve
