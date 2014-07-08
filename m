From: Yuyang Du <yuyang.du@intel.com>
Subject: Re: [RFCv2 PATCH 00/23] sched: Energy cost model for energy-aware
 scheduling
Date: Tue, 8 Jul 2014 08:23:43 +0800
Message-ID: <20140708002343.GC25653@intel.com>
References: <1404404770-323-1-git-send-email-morten.rasmussen@arm.com>
 <20140703231950.GA4881@intel.com>
 <20140704110612.GA6120@e103034-lin>
 <20140706190523.GA12113@intel.com>
 <20140707141627.GB4485@e103687>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140707141627.GB4485@e103687>
Sender: linux-kernel-owner@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "mingo@kernel.org" <mingo@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, "pjt@google.com" <pjt@google.com>
List-Id: linux-pm@vger.kernel.org

Hi Morten,

On Mon, Jul 07, 2014 at 03:16:27PM +0100, Morten Rasmussen wrote:

> Could you elaborate on what you mean by 'a general statement'?

The general statement is: higher freq, more cap, and more power. More specific
numbers are not needed, as they are just instances of this general statement.

> cpu_power doesn't tell you anything about energy-efficiency. There is no
> link with frequency scaling.

In general, more cpu_power, more freq, less energy-efficiency, as you said sometime ago.

> No representation of power domains.

Represented by CPU topology?

Thanks,
Yuyang
