From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend
	and	hibernation callbacks (rev. 8)
Date: Mon, 14 Apr 2008 08:47:02 +1000
Message-ID: <1208126822.6958.63.camel__42697.3660280511$1208126935$gmane$org@pasglop>
References: <200804040111.15255.rjw@sisk.pl>
	<200804132339.45280.rjw@sisk.pl> <1208124646.6958.61.camel@pasglop>
	<200804140027.12161.rjw@sisk.pl>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200804140027.12161.rjw@sisk.pl>
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


> Well, I'm not sure and I'm not going to introduce the change right now, after
> the paches have been included in -mm.
> 
> That would require quite some changes in the core code that I'd prefer to
> avoid for now.  We can do something like this in a separate patch series after
> the present one settles down a bit.

I disagree.

Doing it later would introduce yet another major semantic change.

I think we should get it right now. There's no hurry in pushing things
especially if they aren't quite right.

The ability for prepare() callbacks to sync with userland,
request_firmware, etc... is an important feature that's been needed for
some time imho.

Ben.
