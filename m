From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Thu, 5 Aug 2010 17:09:17 +0100
Message-ID: <20100805160912.GA28689__5097.91530571437$1281027305$gmane$org@sirena.org.uk>
References: <alpine.DEB.2.00.1008041554580.6545@asgard.lang.hm>
	<AANLkTingom2AKfMu0EbfdfLiMnHo+buy1e4=PBENf3Vi@mail.gmail.com>
	<alpine.DEB.2.00.1008041620010.6545@asgard.lang.hm>
	<20100804233013.GN24163@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008041643490.6545@asgard.lang.hm>
	<20100805001716.GO24163@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008041722060.6545@asgard.lang.hm>
	<20100805004802.GP24163@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008042208350.25170@asgard.lang.hm>
	<20100805151211.GA10080@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100805151211.GA10080@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: david@lang.hm, peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 05, 2010 at 08:12:11AM -0700, Paul E. McKenney wrote:
> On Wed, Aug 04, 2010 at 10:18:40PM -0700, david@lang.hm wrote:

> > as for intramentation, the key tool to use to see why a system isn't
> > going to sleep would be powertop, just like on other linux systems.

> Powertop is indeed an extremely valuable tool, but I am not certain
> that it really provides the information that the Android guys need.
> If I understand Arve's and Brian's posts, here is the scenario that they
> are trying to detect:

> o	Some PM-driving application has a bug in which it fails to
> 	release a wakelock, thus blocking suspend indefinitely.

> o	This PM-driving application, otherwise being a good citizen,
> 	blocks.

> o	There are numerous power-oblivious apps running, consuming
> 	significant CPU.

Or otherwise doing something power hungry.

> What the Android developers need to know is that the trusted application
> is wrongly holding a wakelock.  Won't powertop instead tell them about
> all the power-oblivious apps?

Right, and this isn't just information for developers - Android handsets
expose this information to end users (so they can indentify any badly
behaved applications they have installed or otherwise modify their
handset usage if they are disappointed by their battery life).  That
said, powertop and similar applications could always be extended to also
include data from wakelocks.
