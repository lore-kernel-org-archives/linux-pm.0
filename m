From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] i915 / PM: Fix hibernate regression caused
 by suspend/resume splitting
Date: Mon, 22 Feb 2010 08:32:36 -0800
Message-ID: <20100222083236.45bf150d__49843.6443544508$1266856554$gmane$org@jbarnes-piketon>
References: <74fd948d1002171047g70d2bba0l957e264dfbc8ea23@mail.gmail.com>
	<201002172320.57491.rjw@sisk.pl>
	<74fd948d1002171629v7e86371cna4441e8feb27c326@mail.gmail.com>
	<201002182306.28052.rjw@sisk.pl>
	<alpine.LFD.2.00.1002220746260.4141@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1002220746260.4141@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pedro Ribeiro <pedrib@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>
List-Id: linux-pm@vger.kernel.org

On Mon, 22 Feb 2010 07:47:53 -0800 (PST)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> Jesse, Eric, what's the status of this patch? 
> 
> Should I take it directly (I'd really like an Ack) or is it queued up in 
> some tree waiting for me to pull? Or is there some reason not to have it, 
> despite it fixing things for some people?

Hm, I thought Eric had applied that to his for-linus branch, but it
looks like that branch is empty now.  Maybe Rafael posted an update
that Eric missed and so you just have a partial fix in your tree?

-- 
Jesse Barnes, Intel Open Source Technology Center
