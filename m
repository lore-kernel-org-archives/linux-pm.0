From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [BUG] function_graph trace causes  hang when using sleepgraph
 (4.15.0-rc1 and newer)
Date: Tue, 9 Jan 2018 11:13:34 -0500
Message-ID: <20180109111334.2628dcc5@vmware.local.home>
References: <1515455714.17761.7.camel@linux.intel.com>
        <1515459749.17761.10.camel@linux.intel.com>
        <20180108200756.08712bb4@vmware.local.home>
        <1515461115.17761.12.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932898AbeAIQNh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Jan 2018 11:13:37 -0500
In-Reply-To: <1515461115.17761.12.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Todd Brandt <todd.e.brandt@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, len.brown@intel.com, todd.e.brandt@intel.com

On Mon, 08 Jan 2018 17:25:15 -0800
Todd Brandt <todd.e.brandt@linux.intel.com> wrote:

> Can you reproduce the issue there? I just want to be sure it's not
> something local to our machines here, as long as you have CONFIG_PM
> enabled it should work the same hopefully. 

Just to let you know, I'm currently traveling, so my testing ability is
limited at the time being.

-- Steve
