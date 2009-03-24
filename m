From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][PATCH 0/2] Export
 platform_pci_set_power_state() and make radeonfb use it
Date: Wed, 25 Mar 2009 08:12:55 +1100
Message-ID: <1237929175.25062.727.camel__24419.7586588145$1237929539$gmane$org@pasglop>
References: <200903210003.55161.rjw@sisk.pl>
	<1237856239.25062.696.camel@pasglop>
	<20090323181420.30125d59@hobbes.virtuouswap>
	<200903241200.37982.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903241200.37982.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Alex Deucher <alexdeucher@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2009-03-24 at 12:00 +0100, Rafael J. Wysocki wrote:

> In fact I have yet another idea.  If we use the "retransmission with exponential
> backoff" algorithm in pci_raw_set_power_state(), we won't have to add any
> extra parameters to pci_set_power_state() and the radeon case will be covered
> automatically.  That should also cover any other devices having similar
> problems IMO.
> 
> A patch to implement that is appended, please tell me what you think.

This is crazy....

Most devices don't need that and those who are a bit "touchy" may well
puke on being written to too fast while they are in the middle of
the transition.

Let's wait to see if Alex from ATI has an answer here, and if not, I
would suggest keeping the dirt inside radeonfb.

Ben.
