From: Geoff Levand <geoff@infradead.org>
Subject: Re: [PATCH V3 1/6] powerpc: Free up the IPI message slot of ipi
 call function (PPC_MSG_CALL_FUNC)
Date: Wed, 11 Sep 2013 09:49:58 -0700
Message-ID: <1378918198.19147.28.camel@smoke>
References: <20130911024906.27726.4735.stgit@preeti.in.ibm.com>
	 <20130911025100.27726.95866.stgit@preeti.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:51051 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203Ab3IKQuT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2013 12:50:19 -0400
In-Reply-To: <20130911025100.27726.95866.stgit@preeti.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paul.gortmaker@windriver.com, paulus@samba.org, shangw@linux.vnet.ibm.com, rjw@sisk.pl, galak@kernel.crashing.org, fweisbec@gmail.com, paulmck@linux.vnet.ibm.com, arnd@arndb.de, linux-pm@vger.kernel.org, rostedt@goodmis.org, michael@ellerman.id.au, john.stultz@linaro.org, tglx@linutronix.de, chenhui.zhao@freescale.com, deepthi@linux.vnet.ibm.com, r58472@freescale.com, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, schwidefsky@de.ibm.com, svaidy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org

On Wed, 2013-09-11 at 08:21 +0530, Preeti U Murthy wrote:
>  arch/powerpc/platforms/ps3/smp.c        |    2 +-

The PS3 part is trivial and looks OK.

Acked-by: Geoff Levand <geoff@infradead.org>

