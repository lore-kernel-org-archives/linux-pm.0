From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v5] power: new trace event to print device suspend and
 resume time
Date: Fri, 19 Jul 2013 14:37:53 -0400
Message-ID: <1374259073.3356.22.camel@gandalf.local.home>
References: <1374187352-3283-1-git-send-email-shuah.kh@samsung.com>
	 <1374188013.3356.7.camel@gandalf.local.home>
	 <B8EFE96D1287C24090BAD9D858E15E61743340@sisaex01sj>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <B8EFE96D1287C24090BAD9D858E15E61743340@sisaex01sj>
Sender: linux-kernel-owner@vger.kernel.org
To: Shuah Khan <shuah.kh@samsung.com>
Cc: "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "rjw@sisk.pl" <rjw@sisk.pl>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "fweisbec@gmail.com" <fweisbec@gmail.com>, "mingo@redhat.com" <mingo@redhat.com>, "paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>, "joe@perches.com" <joe@perches.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shuahkhan@gmail.com" <shuahkhan@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 2013-07-19 at 18:29 +0000, Shuah Khan wrote:

> Tried with temp variables. Patch is on its way with temp variables. I 
> generated .s with and without temp variables and didn't see any 
> difference. Should I be seeing a difference, if so what am I missing?
> 
> In any case, you have the patch v6 with temp variables.
> 

There may not be, matters how good gcc is in optimization.

Temp variables are fine to keep if they work.

-- Steve
