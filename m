From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 05/22] PM / AVS: SmartReflex: %pF is only for function
 pointers
Date: Thu, 12 Mar 2015 14:16:36 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1503121415560.24876@pobox.suse.cz>
References: <1426130037-17956-1-git-send-email-scottwood@freescale.com> <1426130037-17956-5-git-send-email-scottwood@freescale.com> <7hy4n2w0ix.fsf@deeprootsystems.com> <5501D78E.10102@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58931 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753066AbbCLSQj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 12 Mar 2015 14:16:39 -0400
In-Reply-To: <5501D78E.10102@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@kernel.org>, Scott Wood <scottwood@freescale.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Thu, 12 Mar 2015, Nishanth Menon wrote:

> > Scott Wood <scottwood@freescale.com> writes:
> > 
> >> Use %pS for actual addresses, otherwise you'll get bad output
> >> on arches like ppc64 where %pF expects a function descriptor.
> >>
> >> Signed-off-by: Scott Wood <scottwood@freescale.com>
> >> Cc: linux-pm@vger.kernel.org
> >> Cc: Kevin Hilman <khilman@kernel.org>
> >> Cc: Nishanth Menon <nm@ti.com>
> > 
> > Acked-by: Kevin Hilman <khilman@linaro.org>
> > 
> Acked-by: Nishanth Menon <nm@ti.com>
> 
> I suppose this goes via Jiri Kosina's trivial tree?

Thanks. I am putting this on hold for a couple days to see who applied to 
which tree, gather acks, and merge what's outstanding through trivial 
tree.

-- 
Jiri Kosina
SUSE Labs
