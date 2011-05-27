From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [RFC PATCH v3] ARM hibernation/suspend-to-disk
	support
Date: Fri, 27 May 2011 15:27:18 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1105271501220.3207__40556.9849689074$1306868771$gmane$org@xanadu.home>
References: <alpine.DEB.2.00.1105251251330.4319@localhost6.localdomain6>
	<alpine.DEB.2.00.1105271549220.6109@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <alpine.DEB.2.00.1105271549220.6109@localhost6.localdomain6>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Frank Hofmann <frank.hofmann@tomtom.com>
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@tuxonice.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, 27 May 2011, Frank Hofmann wrote:

>  /*
>   * r0 = control register value
>   * r1 = v:p offset (preserved by cpu_do_resume)
> + *      if this is zero, do not reenable MMU (it's on)

This is wrong.  It is well possible for this to be zero when the MMU is 
active.

The best way to determine if MMU is on or off is:

	mrc	p15, 0, rx, c1, c0	@ load ctrl reg
	tst	rx, #1			@ test M bit

> I wonder; is there a proper/suggested way to switch MMU off (and not end in
> binary nirvana), to have the reentry / reenable work ?

This is slightly complicated.  You first need to turn of and disable the 
caches, and ideally set up a 1:1 mapping for the transition.  There are 
cpu_proc_fin() and cpu_reset(branch_location).

You may also investigate how kexec is handled which purpose is to let 
the kernel boot another kernel.


Nicolas
