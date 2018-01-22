From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/pseries/cpuidle: add polling idle for shared processor guests
Date: Mon, 22 Jan 2018 14:34:16 +1100 (AEDT)
Message-ID: <3zPxqr75DVz9t20@ozlabs.org>
References: <20171010071109.31207-1-npiggin@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:55677 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751107AbeAVDeS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 21 Jan 2018 22:34:18 -0500
In-Reply-To: <20171010071109.31207-1-npiggin@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: kvm-ppc@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, linux-pm@vger.kernel.org

On Tue, 2017-10-10 at 07:11:09 UTC, Nicholas Piggin wrote:
> For shared processor guests (e.g., KVM), add an idle polling mode rather
> than immediately returning to the hypervisor when the guest CPU goes
> idle.
> 
> Test setup is a 2 socket POWER9 with 4 guests running, each with vCPUs
> equal to 1/2 of real of CPUs. Saturated each guest with tbench. Using
> polling idle gives about 1.4x throughput.
> 
> Kernel compile speed was not changed significantly.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f2ac428e0edabbca41b9dfe9473a90

cheers
