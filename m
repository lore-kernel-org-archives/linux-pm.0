From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/pseries/cpuidle: add polling idle for shared
 processor guests
Date: Tue, 10 Oct 2017 19:42:14 +1000
Message-ID: <20171010194140.5aec88d9@roar.ozlabs.ibm.com>
References: <20171010071109.31207-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35284 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751826AbdJJJm3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2017 05:42:29 -0400
In-Reply-To: <20171010071109.31207-1-npiggin@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: kvm-ppc@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, 10 Oct 2017 17:11:09 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> For shared processor guests (e.g., KVM), add an idle polling mode rather
> than immediately returning to the hypervisor when the guest CPU goes
> idle.
> 
> Test setup is a 2 socket POWER9 with 4 guests running, each with vCPUs
> equal to 1/2 of real of CPUs. Saturated each guest with tbench. Using
> polling idle gives about 1.4x throughput.

Actually it's even more noticeable when the host is not over subscribed
by the looks. 2.5x-3x increase in throughput for just a single guest.

Thanks,
Nick
