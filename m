From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend
	and	hibernation callbacks (rev. 8)
Date: Mon, 14 Apr 2008 17:50:38 +1000
Message-ID: <1208159438.6958.147.camel__16737.8194899813$1208159563$gmane$org@pasglop>
References: <200804040111.15255.rjw@sisk.pl>
	<200804140843.06088.oliver@neukum.org>
	<1208157816.6958.133.camel@pasglop>
	<200804140937.09915.oliver@neukum.org>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200804140937.09915.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Nigel Cunningham <ncunningham@crca.org.au>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


On Mon, 2008-04-14 at 09:37 +0200, Oliver Neukum wrote:
> > Prepare() should be the right place to call request_firmware() and if
> > that is a problem because of bugs in some USB things, then those bugs
> > should be fixed.
> 
> This isn't a bug. USB simply needs to be able to register (and deregister)
> children to be fully operative. You cannot expect a subsystem to work
> while some core services are not available.

No, and that's why the subsystem in question needs to nicely defer the
operations that it cannot do immediately to until resume. Nothing new
here.

In the case of USB, there are plenty of ways it could be done, from
blocking in whatever ioctl is causing trouble, to putting to-be-added
objects in a list that gets processed later...

Ben.
