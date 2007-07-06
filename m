From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Fri, 06 Jul 2007 19:03:11 +1000
Message-ID: <1183712591.3388.131.camel__19891.9851136909$1183712758$gmane$org@localhost.localdomain>
References: <20070703042916.GA17240@srcf.ucam.org>
	<CF60EC03-0171-4052-924D-57555A393168@mac.com>
	<1183694347.3388.114.camel@localhost.localdomain>
	<200707060935.11186.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707060935.11186.rjw@sisk.pl>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


> On powerbooks you disable the nonboot CPUs before suspending devices, which
> simplifies things _a_ _lot_ in comparison with the general case.

Not that much actually. It avoids having to gather them all in the last
stage at the low level but that isn't really related to what we are
talking about right now.

> If you additionally disable kernel preemption, then you don't need anything
> like the freezer anyway in that case (except for detecting situations in which
> the suspend process can deadlock with a task stuck in the D state holding a
> lock, but that's overkill).

kernel preemption and SMP have nothing to do with it. You can still
schedule because one of the driver suspend() callback is schedul'ing,
maybe waiting for some requests to complete, etc... Happens typically
with the disk suspend callbacks.

I agree that it does lower the likelyness of having a userspace process
pound on the wrong driver at the wrong time though.

Ben.
