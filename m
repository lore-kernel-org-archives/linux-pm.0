From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH 2/3 linux-next] cpufreq: conservative: Fix the logic in
 frequency decrease  checking
Date: Wed, 06 Mar 2013 22:10:51 +0200
Message-ID: <5137A2CB.9030809@semaphore.gr>
References: <51366C70.3020406@semaphore.gr> <51379A80.2090200@verisign.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51379A80.2090200@verisign.com>
Sender: cpufreq-owner@vger.kernel.org
To: David C Niemi <dniemi@verisign.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 03/06/2013 09:35 PM, David C Niemi wrote:
> The "10" sounds like an attempt to add some hysteresis to the up/down decisionmaking.  If you take it out, you should make sure you don't get into situations where you're continually switching rapidly between two frequencies.  (In the ondemand governor some care was also taken to avoid the cost of doing a CPU idleness evaluation counting towards the CPU looking busy enough to upshift; I am not familiar enough with Conservative to know whether that is a problem for it too).
> 
> DCN

This is true for ondemand but, as you know, there is a separate tunable 
(down_threshold) in conservative with default value 20.
It's independent from up_threshold (default 80), so I believe there is no
need to add a hysteresis.
Also, if we subtract 10 from down_threshold, we change user's decision
about this threshold. For example, if user sets down_threshold to 25, wants
this value to 25 not to 15.

Checking the initial commit of conservative governor, we can see that it
was not use hysteresis factor. This was added later (by mistake in my opinion)
as an attempt to make conservative to function similar to ondemand.
