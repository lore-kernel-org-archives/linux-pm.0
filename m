From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] i915 / PM: Fix hibernate regression caused
 by suspend/resume splitting
Date: Mon, 22 Feb 2010 07:47:53 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1002220746260.4141__11178.5504654565$1266853744$gmane$org@localhost.localdomain>
References: <74fd948d1002171047g70d2bba0l957e264dfbc8ea23@mail.gmail.com>
	<201002172320.57491.rjw@sisk.pl>
	<74fd948d1002171629v7e86371cna4441e8feb27c326@mail.gmail.com>
	<201002182306.28052.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002182306.28052.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pedro Ribeiro <pedrib@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>
List-Id: linux-pm@vger.kernel.org


Jesse, Eric, what's the status of this patch? 

Should I take it directly (I'd really like an Ack) or is it queued up in 
some tree waiting for me to pull? Or is there some reason not to have it, 
despite it fixing things for some people?

		Linus
