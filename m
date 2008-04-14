From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend
	and	hibernation callbacks (rev. 8)
Date: Mon, 14 Apr 2008 13:23:00 +1000
Message-ID: <1208143380.6958.105.camel__41190.4658926234$1208143522$gmane$org@pasglop>
References: <200804040111.15255.rjw@sisk.pl>
	<200804140231.32245.rjw@sisk.pl> <1208134017.6958.94.camel@pasglop>
	<200804140309.22057.rjw@sisk.pl>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200804140309.22057.rjw@sisk.pl>
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


> To avoid breaking things (from the functional point of view) unnecessarily.
> 
> In short, I don't really see the difference between moving ->prepare() before
> the freezer and droppig the freezer, which I'm not going to do right now.

I believe the use of prepare for things like request_firmware etc... is
worth the effort of fixing the known breakage of not having the freezer
while preventing insertion of new devices (mostly USB). In fact, it
won't be such a big issue as the core should/will return an error from
attempting to add the device in that case.

Ben.
