From: jacob pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v5 3/3] PM: Introduce Intel PowerClamp Driver
Date: Fri, 4 Jan 2013 08:51:13 -0800
Message-ID: <20130104085113.00001574@unknown>
References: <1357225804-27191-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1357225804-27191-4-git-send-email-jacob.jun.pan@linux.intel.com>
	<1357271464.5452.31.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:35810 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755018Ab3ADQvQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Jan 2013 11:51:16 -0500
In-Reply-To: <1357271464.5452.31.camel@joe-AO722>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Zhang Rui <rui.zhang@intel.com>, Rob Landley <rob@landley.net>, Arjan van de Ven <arjan@linux.intel.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>

On Thu, 03 Jan 2013 19:51:04 -0800
Joe Perches <joe@perches.com> wrote:

> On Thu, 2013-01-03 at 07:10 -0800, Jacob Pan wrote:
> > Intel PowerClamp driver performs synchronized idle injection across
> > all online CPUs. The goal is to maintain a given package level
> > C-state ratio.
> 
> []
> 
> > +static int window_size_set(const char *arg, const struct
> > kernel_param *kp) +{
> > +	int ret = 0;
> > +	unsigned long new_window_size;
> > +
> > +	ret = kstrtoul(arg, 10, &new_window_size);
> > +	if (ret)
> > +		goto exit_win;
> > +	if (new_window_size > 10 || new_window_size < 2) {
> > +		pr_err("Invalid window size %lu, between 2-10\n",
> > +			new_window_size);
> > +		ret = -EINVAL;
> > +	}
> > +
> > +	window_size = new_window_size;
> 
> Possible assignment of known invalid windows size?
> Maybe you should add
> 	goto exit;
> after
> 	ret = -EINVAL;
> 
> or add
> 	new_window_size = clamp(new_window_size, 2ul, 10ul);
Good catch. The window size range 2-10 is somewhat arbitrary, greater
than 10 should also work just not recommended. I will reword that. But
it is good to clamp it as you suggested, i will do that for the
duration parameter also.

Thanks,

Jacob
