From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFD] Automatic suspend
Date: Mon, 16 Feb 2009 13:12:40 +1100
Message-ID: <1234750360.26036.115.camel__8044.4112689749$1234750654$gmane$org@pasglop>
References: <200902160010.16955.rjw@sisk.pl>
	<20090215164456.34aef7e8@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090215164456.34aef7e8@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 2009-02-15 at 16:44 -0800, Arjan van de Ven wrote:
> On Mon, 16 Feb 2009 00:10:15 +0100
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > Hi,
> > 
> > The recent descussion about the Android PM patches sent by Arve shows
> > that there is a need to introduce a mechanism allowing us to:
> > (1) automatically put the system as a whole into a sleep state (eg.
> > suspend to RAM) when it is found to be "idle", where the meaning of
> > "idle" has to be defined too,
> > (2) put given subset of devices into low power states whenever they
> > are not used, without putting the entire system into a sleep state.
> 
> 
> For (2), for me the answer is very obvious:

 .../...

I agree with pretty much everything Arjan wrote here.

> Userland should never ever control the state of a device like this
> directly. It should do so by a) closing the device and b) setting
> latency / functional requirements

With the possible exception of things like wifi/bt killswitch or network
or similar where the driver cannot shut the device down without losing
the ability to detect activity (ie, switch your PHY off is nice but you
lose the ability to monitor the link for example).

Cheers,
Ben.
