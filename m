From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend
	and	hibernation callbacks (rev. 8)
Date: Mon, 14 Apr 2008 10:43:10 +1000
Message-ID: <1208133790.6958.89.camel__36211.6093085662$1208133979$gmane$org@pasglop>
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

Note that the above seems to lack any useful information (as usual) such
as what block driver is involved etc...

We fixed IDE to be robust vs. pending IOs a while ago. It's possible
that libata isn't as solid yet, I don't know.

This needs to be done regardless of feezer vs. not freezer. There are
thins in the kernel that can trigger BIOs at any time pretty much
regardless of user space being frozen or not, again, it's a case of
sticking our head in the sand and hoping the freezer hides all our
design bugs.

Ben.
