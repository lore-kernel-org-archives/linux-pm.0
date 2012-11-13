From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 3/3] PM: Introduce Intel PowerClamp Driver
Date: Mon, 12 Nov 2012 22:55:02 -0800
Message-ID: <20121112225502.17421024@chromoly>
References: <1352757831-5202-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1352757831-5202-4-git-send-email-jacob.jun.pan@linux.intel.com>
	<1352788416.24230.6.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352788416.24230.6.camel@joe-AO722>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Zhang Rui <rui.zhang@intel.com>, Rob Landley <rob@landley.net>, Arjan van de Ven <arjan@linux.intel.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 12 Nov 2012 22:33:36 -0800
Joe Perches <joe@perches.com> wrote:

> > Intel PowerClamp driver performs synchronized idle injection across
> > all online CPUs. The goal is to maintain a given package level
> > C-state ratio.  
> 
> style trivia:
they are all good catches. will fix in the next version.

-- 
Thanks,

Jacob
