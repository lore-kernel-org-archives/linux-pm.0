From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 03 Jul 2007 15:48:26 +1000
Message-ID: <1183441706.10386.73.camel__32099.9634023339$1183441996$gmane$org@localhost.localdomain>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707031454.42078.nigel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707031454.42078.nigel@nigel.suspend2.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <nigel@nigel.suspend2.net>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


> Note, though, that this won't help at all when people use the "suspend-to-ram 
> instead of powering down after writing a hibernation image" feature in 
> (uswsusp | tuxonice). Fuse is just a broken idea in the first place, but 
> given that it exists, we still need to find the underlying cause.

No, Fuse is not a broken idea in the first place. It's the freezer that
is a totally broken idea. It has proven many times to be racy by design
and cannot be made right. Ther usermode helper mess is just part of
that, fuse is another example, etc etc ...

So I think Matthew is totally right. In fact, the presence of the
freezer is the main reason why Paulus so far NACKed Johannes attempts at
merging the PPC PM code with the generic code in kernel/power.c

We've been doing fine without it so far and intend to continue to do so.

As for suspend-to-disk, I refer you to the discussions we had in the
past with Linus, where he explains I think quite clearly how wrong the
current implementation of STR is :-)

Thing is, if you're going to do snapshots, you should probably not sync
after you have "frozen" anyway.

Cheers,
Ben.
