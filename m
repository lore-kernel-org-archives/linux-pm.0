From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v4 3/3] Revert "arm64: hibernate: Refuse to hibernate if
 the boot cpu is offline"
Date: Tue, 5 Jul 2016 18:49:21 +0100
Message-ID: <20160705174921.GL3565@e104818-lin.cambridge.arm.com>
References: <1467643950-11034-1-git-send-email-james.morse@arm.com>
 <1467643950-11034-4-git-send-email-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54368 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752862AbcGERt0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 5 Jul 2016 13:49:26 -0400
Content-Disposition: inline
In-Reply-To: <1467643950-11034-4-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-pm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Chen Yu C <yu.c.chen@intel.com>, Will Deacon <will.deacon@arm.com>, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org

On Mon, Jul 04, 2016 at 03:52:30PM +0100, James Morse wrote:
> Now that we use the MPIDR to resume on the same CPU that we hibernated on,
> we no longer need to refuse to hibernate if the boot cpu is offline. (Which
> we can't possibly know if kexec causes logical CPUs to be renumbered).
> 
> This reverts commit 1fe492ce6482b77807b25d29690a48c46456beee.
> 
> Signed-off-by: James Morse <james.morse@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
