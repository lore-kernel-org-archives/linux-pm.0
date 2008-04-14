From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend
	and	hibernation callbacks (rev. 8)
Date: Mon, 14 Apr 2008 17:23:36 +1000
Message-ID: <1208157816.6958.133.camel@pasglop>
References: <200804040111.15255.rjw@sisk.pl>
	<200804140309.22057.rjw@sisk.pl> <1208143380.6958.105.camel@pasglop>
	<200804140843.06088.oliver@neukum.org>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200804140843.06088.oliver@neukum.org>
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


On Mon, 2008-04-14 at 08:43 +0200, Oliver Neukum wrote:
> 
> Which is the problem. Suspension is supposed to be transparent.
> We cannot start returning error codes for operations which never
> failed in practice (eg. switching configurations in USB), just because
> the system is about to be suspended.

Returning errors is better than crashing in any way. So what I meant
here is that the problem is not as bad as it sounds.

> If you want to request firmware in a PM callback, which makes a
> certain
> sense, as we should move to a comprehensive API, if we change the API
> at all, we need a model with 3 callbacks.

No. At this pace, we'll find reasons to have 98213674 callbacks and will
still not be happy.

Prepare() should be the right place to call request_firmware() and if
that is a problem because of bugs in some USB things, then those bugs
should be fixed.

Ben.
