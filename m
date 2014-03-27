From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4] powernv: Dynamic Frequency Scaling Enablement
Date: Thu, 27 Mar 2014 17:28:44 +1100
Message-ID: <1395901724.5569.83.camel@pasglop>
References: <1395852947-22290-1-git-send-email-ego@linux.vnet.ibm.com>
	 <CAKohpom-mnOXpOUChasOMVTrRGknvZNA_bOcq6ZfGTRmUM5W9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:54692 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751881AbaC0G3E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 27 Mar 2014 02:29:04 -0400
In-Reply-To: <CAKohpom-mnOXpOUChasOMVTrRGknvZNA_bOcq6ZfGTRmUM5W9A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, Linux PM list <linux-pm@vger.kernel.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>

On Thu, 2014-03-27 at 11:08 +0530, Viresh Kumar wrote:
> On 26 March 2014 22:25, Gautham R. Shenoy <ego@linux.vnet.ibm.com> wrote:
> > This is the v4 of the patchset to enable Dynamic Frequency Scaling
> > on IBM PowerNV Platforms. I have incorporated the review comments
> > from the previous version (can be found at [1]).
> 
> I wouldn't have added a cover-letter if I only have a single patch to
> send. Would have rather used the not-to-be-commited field of the
> patch instead.

Any other comment ? :-)

Because it depends on some other stuff in -next, I think it's best if
this gets merged via Rafael's tree, unless someone can point me at
the necessary pre-requisites in the form of a topic branch I can
pull in powerpc along with this.

Cheers,
Ben.

