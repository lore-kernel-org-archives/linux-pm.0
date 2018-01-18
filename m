From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: Re: [BUG] function_graph trace causes  hang when using sleepgraph
 (4.15.0-rc1 and newer)
Date: Thu, 18 Jan 2018 09:21:08 -0800
Message-ID: <1516296068.30183.1.camel@linux.intel.com>
References: <1515455714.17761.7.camel@linux.intel.com>
         <1515459749.17761.10.camel@linux.intel.com>
         <20180108200756.08712bb4@vmware.local.home>
         <1515461115.17761.12.camel@linux.intel.com>
         <20180109111334.2628dcc5@vmware.local.home>
Reply-To: todd.e.brandt@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180109111334.2628dcc5@vmware.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

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
> 
> -- Steve

I just tested 4.15.0-rc8 (with the ring_buffer changes) and it appears
to work correctly now, thanks!
