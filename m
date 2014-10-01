From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Xen-devel] [PATCH v1 1/2] genirq: Fix error path for resuming
 irqs
Date: Thu, 2 Oct 2014 01:45:03 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1410020109400.4269@nanos>
References: <1403913865-31614-1-git-send-email-dbasehore@chromium.org> <CAGAzgsqEwVFHh2+Xtmraxb6Xwt_Rz2iTsOz+R+P-wmc4Vq9-mg@mail.gmail.com> <2820251.cyKiTY1p5v@vostro.rjw.lan> <6351010.TOHuEbTbVD@vostro.rjw.lan>
 <CAGAzgso4WUMF+DiOk8=WV62LdMhcQ6osPjdbEwiOnW1JXfUAFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:40563 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbaJAXpR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Oct 2014 19:45:17 -0400
In-Reply-To: <CAGAzgso4WUMF+DiOk8=WV62LdMhcQ6osPjdbEwiOnW1JXfUAFA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "dbasehore ." <dbasehore@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel <linux-kernel@vger.kernel.org>, xen-devel@lists.xenproject.org, Laxman Dewangan <ldewangan@nvidia.com>, Ian Campbell <ian.campbell@citrix.com>, Linux-pm mailing list <linux-pm@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Eric Biederman <ebiederm@xmission.com>

On Wed, 1 Oct 2014, dbasehore . wrote:
> On Wed, Oct 1, 2014 at 3:30 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

Please stop top-posting and trim the quoted text. This is not your
$corp mail drop.

> dpm_resume_noirq is not early enough for the Xen stuff, but should be
> early enough for other stuff. This patch is mostly just a bandage on
> top of the broken IRQF_EARLY_RESUME code.

You are getting it really backwards.

The IRQF_EARLY_RESUME stuff was introduced on behalf of XEN and now
you are claiming in your changelog that:
 
> >> > >> This regression was introduced in 9bab0b7f "genirq: Add IRQF_RESUME_EARLY"

So you are fixing a 3+ years old regression here? Do you have any
prove that the code worked before that commit 9bab0b7f went in during
the 3.2 merge window?

No, you don't. Simply because the XEN suspend/resume stuff was not
working at all before that. So it's not a regression.

It either was a wrong design decision back then which did not take an
error path into account or the things have changed in a way that this
mechanism does not work anymore.

I agree with Rafael that this should be solved differently. Though I'm
not really convinced of the proposed syscore solution, simply because
it will introduce another "tolerated" way for people to work around
totally unrelated shortcomings of other parts of the suspend/resume
machinery.

You noticed yourself that

> .... some rtc drivers started using IRQF_EARLY_RESUME. I can't think
> of any reason those drivers would need to be resumed early. This
> way, the flag wouldn't even be there for people to mistakenly add.

Now the question is WHY XEN is so special that it needs all these
extra features and mechanisms all over the place?

I have not looked into the guts of XEN that deep that I can judge that
and I have no intention to do so as I want to preserve my mental
sanity, but I have not seen any reasonable explanation WHY:

> dpm_resume_noirq is not early enough for the Xen stuff

Is it just because XEN works that way and XEN folks are not willing or
able to make it different? Or is there any fundamental and reasonable
technical reason why XEN needs to have the extra treatment while the
rest of the world does not?

Thanks,

	tglx
