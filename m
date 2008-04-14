From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend and
	hibernation callbacks (rev. 8)
Date: Mon, 14 Apr 2008 02:07:17 +0200
Message-ID: <200804140207.19340.rjw__796.352738007222$1208131722$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0804131916420.3060-100000@netrider.rowland.org>
	<1208130513.6958.72.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1208130513.6958.72.camel@pasglop>
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
> On Sun, 2008-04-13 at 19:23 -0400, Alan Stern wrote:
> > 
> > Thus, in addition to making all the interface changes implied by the 
> > new callbacks, drivers would also have to change the way they
> > interact 
> > with userspace.  Yes, this will have to be done eventually in any
> > case, 
> > as the freezer goes away -- but it shouldn't have to be done right
> > now.
> 
> I disagree. The freezer can already be compiled out and is already not
> used on some architectures.

Please have a look at this thread:
http://lkml.org/lkml/2008/3/21/322
(in short, the reporter sees APM suspend breakage under stress, occuring
because APM uses our suspending of devices without the freezer).

It mostly appears to work without the freezer, but that's bacuse no one
actually does things that might break it.  I don't think we can rely on users
being so kind to us forever. :-)

Thanks,
Rafael
