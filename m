From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 2/2] powercap/rapl: reduce ipi calls
Date: Wed, 24 Feb 2016 12:02:50 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1602241202110.3670@nanos>
References: <1456261152-21907-1-git-send-email-jacob.jun.pan@linux.intel.com> <1456261152-21907-3-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456261152-21907-3-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: linux-pm@vger.kernel.org

On Tue, 23 Feb 2016, Jacob Pan wrote:

> Reduce remote CPU calls for MSR access by combining read
> modify write into one function. Also optimize calling active CPU on
> package by tracking a lead cpu for each package.

This are two independent changes in one patch. Please split them up.
 
Thanks,

	tglx
