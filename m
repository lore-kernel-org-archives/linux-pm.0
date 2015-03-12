From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] powercap/rapl: handle domain energy unit
Date: Thu, 12 Mar 2015 23:24:56 +0100
Message-ID: <3326586.77vrRRoRJD@vostro.rjw.lan>
References: <1426078509-3767-1-git-send-email-jacob.jun.pan@linux.intel.com> <14265283.qm1vXaZEIU@vostro.rjw.lan> <20150312131739.4dbef312@icelake>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150312131739.4dbef312@icelake>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, March 12, 2015 01:17:39 PM Jacob Pan wrote:
> On Wed, 11 Mar 2015 23:01:30 +0100
> "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> 
> > On Wednesday, March 11, 2015 05:55:09 AM Jacob Pan wrote:
> > > The current driver assumes all RAPL domains within a CPU package
> > > have the same energy unit. This is no longer true for HSW server
> > > CPUs since DRAM domain has is own fixed energy unit which can be
> > > different than the package energy unit enumerated by package
> > > power MSR. In fact, the default HSW EP package power unit is 61uJ
> > > whereas DRAM domain unit is 15.3uJ. The result is that DRAM power
> > > consumption is counted 4x more than real power reported by energy
> > > counters.
> > > 
> > > This patch adds domain specific energy unit per cpu type, it allows
> > > domain energy unit to override package energy unit if non zero.
> > > 
> > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > 
> > Should I regard this as a fix for 4.0?  If so, should it also go to
> > "stable" (and which "stable" series should it go to in that case)?
> > 
> yes, it is a bug fix. I think this should be applied to all stable
> kernels since RAPL driver was merged. So 3.10.71 and later.

OK
