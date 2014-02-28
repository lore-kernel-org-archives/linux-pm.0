From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC] Splitting scheduler into two halves
Date: Fri, 28 Feb 2014 12:44:59 +0100
Message-ID: <20140228114459.GM27965@twins.programming.kicks-ass.net>
References: <0DA73B5D686AEC4AAEF6054BE04DA1CD116C50EA@SHSMSX102.ccr.corp.intel.com>
 <20140228102932.GI19029@e103034-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140228102932.GI19029@e103034-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: "Du, Yuyang" <yuyang.du@intel.com>, Ingo Molnar <mingo@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>, "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 28, 2014 at 10:29:32AM +0000, Morten Rasmussen wrote:
> If I understand your proposal correctly, you are proposing to have a
> pluggable scheduler where it is possible to have many different
> load-balance (bottom half) implementations.

Yeah, that's not _ever_ going to happen. We've had that discussion many
times, use your favourite search engine.
