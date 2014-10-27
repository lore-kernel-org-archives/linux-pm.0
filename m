From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] cpuidle/powernv: Populate cpuidle state details by
 querying the device-tree
Date: Mon, 27 Oct 2014 14:34:30 +1100
Message-ID: <1414380870.24967.0.camel@concordia>
References: <20141014075259.11810.50996.stgit@preeti.in.ibm.com>
	 <20141024143030.GA25966@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:36939 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751998AbaJ0Deg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 26 Oct 2014 23:34:36 -0400
In-Reply-To: <20141024143030.GA25966@red-moon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "shreyas@linux.vnet.ibm.com" <shreyas@linux.vnet.ibm.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Fri, 2014-10-24 at 15:30 +0100, Lorenzo Pieralisi wrote:
> On Tue, Oct 14, 2014 at 08:53:00AM +0100, Preeti U Murthy wrote:
> > We hard code the metrics relevant for cpuidle states in the kernel today.
> > Instead pick them up from the device tree so that they remain relevant
> > and updated for the system that the kernel is running on.
> 
> Device tree properties should be documented, and these bindings are
> getting very similar to the ones I have just completed for ARM,
> I wonder whether we should take the generic bits out of ARM bindings (ie
> exit_latency) and make those available to other architectures.

The firmware that emits those properties is already in the field, so it would
have been nice to use a generic binding but it's too late now.

cheers


