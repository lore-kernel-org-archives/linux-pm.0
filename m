From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/1] x86: replace cpu_up hard-coded mdelay with variable
Date: Mon, 20 Apr 2015 09:13:06 +0200
Message-ID: <20150420071306.GA14315@gmail.com>
References: <1429404795-23260-1-git-send-email-lenb@kernel.org>
 <87d69aab88c14d65ae1e7be55050d1b689b59b4b.1429402494.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34687 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641AbbDTHNL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2015 03:13:11 -0400
Content-Disposition: inline
In-Reply-To: <87d69aab88c14d65ae1e7be55050d1b689b59b4b.1429402494.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>


* Len Brown <lenb@kernel.org> wrote:

> +config X86_INIT_MDELAY
> +	int "Milliseconds to wait to de-assert INIT upon CPU startup" if SMP
> +	range 0 10
> +	default "10"
> +	---help---
> +	  This allows you to specify how long the BSP will delay
> +	  between asserting INIT and de-asserting INIT when starting another CPU.
> +	  This delay is paid on each cpu-online operation, including boot-time,
> +	  resume from suspend, and resume from hibernate.  The the value of
> +	  10 millisec was specified by Multi-Processor Spec 1.4 in 1997.
> +	  But modern hardware does not require any delay.

What's the cutoff for 'modern hardware' - which CPUs stopped requiring 
the delay?

Also, is there any public document where the no-delay is specified for 
'modern hardware'?

Thanks,

	Ingo
