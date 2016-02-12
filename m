From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Avoid unnecessary locking in show() and store()
Date: Fri, 12 Feb 2016 21:28:29 +0530
Message-ID: <20160212155829.GA32705@vireshk-i7>
References: <2946666.LCVBdOefy1@vostro.rjw.lan>
 <20160212063115.GE16949@vireshk-i7>
 <16931364.qnKxgPucoY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <16931364.qnKxgPucoY@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 12-02-16, 14:18, Rafael J. Wysocki wrote:
> Well, having a check that never fails is certainly unuseful.
> 
> > So, even we may want to add a WARN_ON() for that case instead.
> 
> I can add WARN_ON()s just fine.

What about dropping the check completely ?

-- 
viresh
