From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v5 2/2] powercap/rapl: reduce ipi calls
Date: Wed, 24 Feb 2016 13:34:39 -0800
Message-ID: <20160224133439.692402e6@yairi>
References: <1456261152-21907-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1456261152-21907-3-git-send-email-jacob.jun.pan@linux.intel.com>
	<alpine.DEB.2.11.1602241202110.3670@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:54631 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbcBXVel (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 24 Feb 2016 16:34:41 -0500
In-Reply-To: <alpine.DEB.2.11.1602241202110.3670@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, jacob.jun.pan@linux.intel.com

On Wed, 24 Feb 2016 12:02:50 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> This are two independent changes in one patch. Please split them up.
good point. there are actually three changes now.
