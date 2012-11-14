From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH 3/3] PM: Introduce Intel PowerClamp Driver
Date: Tue, 13 Nov 2012 16:08:54 -0800
Message-ID: <50A2E116.8000400@linux.intel.com>
References: <1352757831-5202-1-git-send-email-jacob.jun.pan@linux.intel.com> <1352757831-5202-4-git-send-email-jacob.jun.pan@linux.intel.com> <20121113211602.GA30150@linux.vnet.ibm.com> <20121113133922.47144a50@chromoly> <20121113222350.GH2489@linux.vnet.ibm.com> <50A2CD77.7000403@linux.intel.com> <20121114000259.GK2489@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49865 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756039Ab2KNAJH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 13 Nov 2012 19:09:07 -0500
In-Reply-To: <20121114000259.GK2489@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Zhang Rui <rui.zhang@intel.com>, Rob Landley <rob@landley.net>


> 
> OK, so the point of clamping all sockets simultaneously is to be able
> to power down the electronics surrounding the sockets as well as the
> sockets themselves?  

yup; memory can go to self refresh etc etc

>If all you cared about was the individual sockets,
> I don't see why you couldn't power the sockets down individually rather
> than in sync with each other.

the hardware that this driver supports does not support powering down sockets individually.

(since the memory controllers are part of the "socket"... it would increase latency
etc etc, and likely wreak havoc with the cache coherency protocols)

> I think I know, but I feel the need to ask anyway.  Why not tell
> RCU about the clamping?

I don't mind telling RCU, but what cannot happen is a bunch of CPU time suddenly getting used
(since that is the opposite of what is needed at the specific point in time of going idle)

