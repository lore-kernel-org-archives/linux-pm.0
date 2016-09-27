From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: Regression in 4.8 - CPU speed set very low
Date: Tue, 27 Sep 2016 10:51:14 -0400
Message-ID: <20160927145114.GM14311@csclub.uwaterloo.ca>
References: <f89dffb9-cc78-9849-9539-74ce89e773cd@lwfinger.net>
 <3919370.SGLjGupePs@vostro.rjw.lan>
 <075788ab-34e0-803c-f2b4-3f370ecc6b14@lwfinger.net>
 <2477506.olat0BX4ex@vostro.rjw.lan>
 <1436996d-078b-aa51-4452-b6655d917135@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436996d-078b-aa51-4452-b6655d917135@lwfinger.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 26, 2016 at 04:28:29PM -0500, Larry Finger wrote:
> Mostly I use a KDE applet named "System load" and look at the "average
> clock", but the same info is also available in /proc/cpuinfo as "cpu MHz".
> When the bug triggers, the system gets very slow, and the cpu fan stops even
> though the cpu is still busy.
> 
> Commit f7816ad, which had run for 7 days without showing the bug, failed
> after about 2 hours today. All my testing since Sept. 9 has been wasted. Oh
> well, that's the way it goes!

Is it possible there is no bug and instead you have a hardware problem?

What I am thinking:

CPU fan stops, then CPU gets busy, CPU overheats, thermal throtling
kicks in to protect CPU and it gets VERY slow.

So maybe you have a bad CPU fan that is getting stuck.  Perhaps even if
you have a motherboard that varies the CPU fan depending on need and the
fan doesn't like the lowest speed and sometimes gets stuck when asked
to go slow.

Of course if the CPU fan is the problem that could explain why it takes
varying amounts of time to see the problem.

I suggest checking what the cpu temperature sensors are showing next
time it gets slow.

-- 
Len Sorensen
