From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend and
	hibernation callbacks (rev. 8)
Date: Mon, 14 Apr 2008 09:37:07 +0200
Message-ID: <200804140937.09915.oliver__33533.8972545744$1208158861$gmane$org@neukum.org>
References: <200804040111.15255.rjw@sisk.pl>
	<200804140843.06088.oliver@neukum.org>
	<1208157816.6958.133.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1208157816.6958.133.camel@pasglop>
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

Am Montag, 14. April 2008 09:23:36 schrieb Benjamin Herrenschmidt:
> 
> On Mon, 2008-04-14 at 08:43 +0200, Oliver Neukum wrote:

> > If you want to request firmware in a PM callback, which makes a
> > certain
> > sense, as we should move to a comprehensive API, if we change the API
> > at all, we need a model with 3 callbacks.
> 
> No. At this pace, we'll find reasons to have 98213674 callbacks and will
> still not be happy.
> 
> Prepare() should be the right place to call request_firmware() and if
> that is a problem because of bugs in some USB things, then those bugs
> should be fixed.

This isn't a bug. USB simply needs to be able to register (and deregister)
children to be fully operative. You cannot expect a subsystem to work
while some core services are not available.

	Regards
		Oliver
