From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] cpupower, add option to display frequencies and latencies without rounding off values
Date: Mon, 05 May 2014 18:06:01 +0200
Message-ID: <1451795.6yxSG0gxlO@skinner>
References: <1398349927-18684-1-git-send-email-prarit@redhat.com> <2505557.Dy0KJtTk9a@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45786 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752214AbaEEQGD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 5 May 2014 12:06:03 -0400
In-Reply-To: <2505557.Dy0KJtTk9a@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Prarit Bhargava <prarit@redhat.com>, linux-pm@vger.kernel.org

On Thursday, May 01, 2014 01:41:34 AM Rafael J. Wysocki wrote:
> On Thursday, April 24, 2014 10:32:07 AM Prarit Bhargava wrote:
...

> > 
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Cc: Thomas Renninger <trenn@suse.de>
> > Cc: linux-pm@vger.kernel.org
> > Acked-by: Thomas Renninger <trenn@suse.de>
> > Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> 
> Thomas, any comments?  Yes, no, don't care?

The patch is ok and introduces a new functionality which
is compatible with the rest by only getting switched on via
an extra parameter.

It should not conflict with my other patches which I forgot
what status there is.
Subject: tools/power/cpupower enhancements/fixes
on linux-pm@lists.linux-foundation.org

Are you going to pick them up, shall I resend?

Thanks,

    Thomas
