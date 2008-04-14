From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend and
	hibernation callbacks (rev. 8)
Date: Mon, 14 Apr 2008 02:50:15 +0200
Message-ID: <200804140250.16893.rjw__40585.77003093$1208134415$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0804131916420.3060-100000@netrider.rowland.org>
	<200804140207.19340.rjw@sisk.pl> <1208133790.6958.89.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1208133790.6958.89.camel@pasglop>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: benh@kernel.crashing.org
Cc: Nigel Cunningham <ncunningham@crca.org.au>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 14 of April 2008, Benjamin Herrenschmidt wrote:
> 
> > Please have a look at this thread:
> > http://lkml.org/lkml/2008/3/21/322
> > (in short, the reporter sees APM suspend breakage under stress, occuring
> > because APM uses our suspending of devices without the freezer).
> 
> Note that the above seems to lack any useful information (as usual) such
> as what block driver is involved etc...
> 
> We fixed IDE to be robust vs. pending IOs a while ago. It's possible
> that libata isn't as solid yet, I don't know.
> 
> This needs to be done regardless of feezer vs. not freezer. There are
> thins in the kernel that can trigger BIOs at any time pretty much
> regardless of user space being frozen or not, again, it's a case of
> sticking our head in the sand and hoping the freezer hides all our
> design bugs.

Now, you are talking about a completely different thing I agree with.

I gave this example just to show that some drivers break without the freezer
if suspend is carried out under stress, nothing else.

My point is (and has always been) that we can't just drop the freezer right now
without causing functional regressions to appear, at least for some users.

If there had not been _any_ other way to do things, we could do that, but IMO
there is a way (that I described in the previous message).

Thanks,
Rafael
