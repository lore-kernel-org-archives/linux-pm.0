From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend
	and	hibernation callbacks (rev. 8)
Date: Mon, 14 Apr 2008 08:10:46 +1000
Message-ID: <1208124646.6958.61.camel__18752.1858410493$1208124804$gmane$org@pasglop>
References: <200804040111.15255.rjw@sisk.pl>
	<200804131533.03150.rjw@sisk.pl> <1208120711.6958.52.camel@pasglop>
	<200804132339.45280.rjw@sisk.pl>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200804132339.45280.rjw@sisk.pl>
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


> > I don't see the point... On the contrary, prepare() is the pefect place
> > to implement handshaking with userspace for drivers that need to do so,
> > such as the DRM.
> 
> This _comment_ reflects the current situation, which is that we freeze tasks
> before a suspend.  When it's no longer necessary to do that, I'll be happy to
> change this comment.  For now, however, that's not the case.

Can't we run the freezer after prepare() instead ?

Ben.
