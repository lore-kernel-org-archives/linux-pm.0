From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] cpuidle: avoid singing capacitors
Date: Tue, 4 Mar 2008 00:09:38 +0100
Message-ID: <20080303230938.GA15255__14197.9020591409$1204585820$gmane$org@one.firstfloor.org>
References: <20080303221752.5169f91d@mjolnir.drzeus.cx>
	<924EFEDD5F540B4284297C4DC59F3DEEA2E8B2@orsmsx423.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <924EFEDD5F540B4284297C4DC59F3DEEA2E8B2@orsmsx423.amr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Belay <abelay@novell.com>, Andi Kleen <andi@firstfloor.org>, Lee Revell <rlrevell@joe-job.com>, Pierre Ossman <drzeus-list@drzeus.cx>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> But, with this patch:
> - we are penalizing good hardware and making them less power efficient
> to match the bad ones.

The question is how much it would be penalized. Most likely the penalty 
is very little. I would agree with Pierre's reasoning for enabling 
it by default: distributions will enable it anyways and it's better
to have the same defaults in the mainline kernel as with distros.

It might be worth researching a good default value though. Perhaps
it can be a lot shorter than the current one, lessing the penalty
even more?

-Andi
