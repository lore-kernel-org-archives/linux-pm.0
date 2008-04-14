From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend
	and	hibernation callbacks (rev. 8)
Date: Mon, 14 Apr 2008 10:40:31 +1000
Message-ID: <1208133631.6958.85.camel__22601.6708453701$1208133887$gmane$org@pasglop>
References: <Pine.LNX.4.44L0.0804131916420.3060-100000@netrider.rowland.org>
	<1208130513.6958.72.camel@pasglop>  <200804140207.19340.rjw@sisk.pl>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200804140207.19340.rjw@sisk.pl>
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
Cc: Nigel Cunningham <ncunningham@crca.org.au>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


> Please have a look at this thread:
> http://lkml.org/lkml/2008/3/21/322
> (in short, the reporter sees APM suspend breakage under stress, occuring
> because APM uses our suspending of devices without the freezer).
> 
> It mostly appears to work without the freezer, but that's bacuse no one
> actually does things that might break it.  I don't think we can rely on users
> being so kind to us forever. :-)

As far as I'm concerned, it's yet another case of the freezer papering
over a problem rather than fixing it properly.

If we're going to introduce new callbacks, we should have the right
semantic from day 1 -and- fix those problems, rather than going to the
same old recursive nonsensical arguments and do things to paper over
problems.

Ben.
