From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [BUG] Kernel splat when taking CPUs offline
Date: Thu, 9 Jul 2015 00:25:52 -0400
Message-ID: <20150709002552.32fa492c@grimm.local.home>
References: <20150708152456.4438d60f@gandalf.local.home>
	<1625417.XZkzNdoaJA@vostro.rjw.lan>
	<20150709040445.GG1805@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20150709040445.GG1805@linux>
Sender: linux-acpi-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Saravana Kannan <skannan@codeaurora.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 9 Jul 2015 09:34:45 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:


> I think it might be related to what I chased down yesterday:
> 
> http://marc.info/?l=linux-kernel&m=143633485824975&w=2
> 
> @Steven: Can you please give this a try ?
> 

Yes that seems to fix my issue as well.

Tested-by: Steven Rostedt <rostedt@goodmis.org>

Thanks!

-- Steve
