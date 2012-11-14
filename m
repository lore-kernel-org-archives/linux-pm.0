From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 3/3] PM: Introduce Intel PowerClamp Driver
Date: Tue, 13 Nov 2012 17:24:49 -0800
Message-ID: <20121113172449.0f7b1754@chromoly>
References: <1352757831-5202-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1352757831-5202-4-git-send-email-jacob.jun.pan@linux.intel.com>
	<20121113211602.GA30150@linux.vnet.ibm.com>
	<20121113133922.47144a50@chromoly>
	<20121113222350.GH2489@linux.vnet.ibm.com>
	<50A2CD77.7000403@linux.intel.com>
	<20121114000259.GK2489@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:12231 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932345Ab2KNBYv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 13 Nov 2012 20:24:51 -0500
In-Reply-To: <20121114000259.GK2489@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Cc: Arjan van de Ven <arjan@linux.intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Zhang Rui <rui.zhang@intel.com>, Rob Landley <rob@landley.net>

On Tue, 13 Nov 2012 16:03:00 -0800
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> Just to make sure I am really understanding what is happening, let's
> suppose we have a HZ=1000 system that has a few tasks that
> occasionally run at prio 99.  These tasks would run during the clamp
> interval, but would (for example) see the jiffies counter remaining
> at the value at the beginning of the clamp interval until the end of
> that interval, when the jiffies counter would suddenly jump by roughly
> six counts, right?

Yes, if there is no interrupts disturb the clamping duration.
We do not mask interrupts which will update jiffies.

-- 
Thanks,

Jacob
