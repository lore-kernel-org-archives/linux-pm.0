From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [RFC] A new CPU load metric for power-efficient scheduler: CPU
 ConCurrency
Date: Fri, 25 Apr 2014 08:23:40 +0200
Message-ID: <1398407020.7893.34.camel@marge.simpson.net>
References: <20140424193004.GA2467@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140424193004.GA2467@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yuyang Du <yuyang.du@intel.com>
Cc: mingo@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, arjan.van.de.ven@intel.com, len.brown@intel.com, rafael.j.wysocki@intel.com, alan.cox@intel.com, mark.gross@intel.com, morten.rasmussen@arm.com, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2014-04-25 at 03:30 +0800, Yuyang Du wrote:

> To track CC, we intercept the scheduler in 1) enqueue, 2) dequeue, 3)
> scheduler tick, and 4) enter/exit idle.

Boo hiss to 1, 2 and 4.  Less fastpath math would be better.

-Mike
