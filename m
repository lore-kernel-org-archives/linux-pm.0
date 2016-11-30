From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [patch V2 00/12] thermal/x86_pkg_temp: Sanitize hotplug and
 locking
Date: Wed, 30 Nov 2016 20:30:03 +0800
Message-ID: <1480509003.2202.6.camel@intel.com>
References: <20161122175256.922158782@linutronix.de>
         <1479844260.6544.220.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:2258 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753438AbcK3MaP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 30 Nov 2016 07:30:15 -0500
In-Reply-To: <1479844260.6544.220.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "edubezval@gmail.com" <edubezval@gmail.com>, "peterz@infradead.org" <peterz@infradead.org>, "rt@linutronix.de" <rt@linutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>

On Tue, 2016-11-22 at 12:51 -0700, Pandruvada, Srinivas wrote:
> On Tue, 2016-11-22 at 17:57 +0000, Thomas Gleixner wrote:
> > 
> > Changes vs. V1: Fix the package removal wreckage reported by
> > Srinivas
> > 
> I haven't looked at individual patch but tested the series as a
> whole. 
> 
> So Rui, you can add
> 
> Tested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 

applied.

thanks,
rui
