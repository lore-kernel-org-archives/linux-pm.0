From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: cpufreq governors broken with !CONFIG_SMP?
Date: Fri, 06 May 2016 02:39:11 +0200
Message-ID: <20628091.X3uHbXY5oF@vostro.rjw.lan>
References: <20160505234922.GA14673@sky.smuckle.net> <1961527.dEtpL4HAvs@vostro.rjw.lan> <20160506002519.GB14673@sky.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160506002519.GB14673@sky.smuckle.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, May 05, 2016 05:25:19 PM Steve Muckle wrote:
> On Fri, May 06, 2016 at 02:09:07AM +0200, Rafael J. Wysocki wrote:
> > In turn, schedutil should probably depend on CONFIG_SMP.
> 
> In the long term I wonder if it's worth putting PELT under its own
> separate feature or just removing #ifdef CONFIG_SMP.
> 
> Aside from task migration CPU frequency updates there's also task
> creation and deletion which would apply on UP. The tunable
> infrastructure being created for scheduler-guided frequency may be of
> interest on UP also.

I agree, but I was talking short-term. :-)

We need to fix this for 4.6 (which most likely is 2 weeks away only) and
I don't think it hurts anyone if schedutil depends on CONFIG_SMP to start
with.
