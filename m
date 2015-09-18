From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v6 4/5] devfreq_cooling: add trace information
Date: Fri, 18 Sep 2015 10:04:28 -0400
Message-ID: <20150918100428.0d2f71f5@gandalf.local.home>
References: <1441904972-5809-1-git-send-email-javi.merino@arm.com>
	<1441904972-5809-5-git-send-email-javi.merino@arm.com>
	<20150910131928.3c88fe28@gandalf.local.home>
	<20150918135550.GA5283@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150918135550.GA5283@e104805>
Sender: linux-kernel-owner@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cw00.choi@samsung.com" <cw00.choi@samsung.com>, "edubezval@gmail.com" <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 18 Sep 2015 14:55:51 +0100
Javi Merino <javi.merino@arm.com> wrote:


> > A tracepoint does some whacky things, and gcc may not optimize this.
> 
> I've compared the generated assembly on arm, arm64 and x86_64 and both
> options generate exactly the same code.

Thanks for checking. I was just curious, and I'm wary about trusting
gcc to optimize correctly ;-)


-- Steve
