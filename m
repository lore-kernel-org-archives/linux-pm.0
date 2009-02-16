From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFD] Automatic suspend
Date: Sun, 15 Feb 2009 18:20:12 -0800
Message-ID: <20090215182012.3bc6b292__49797.2248042517$1234751036$gmane$org@infradead.org>
References: <200902160010.16955.rjw@sisk.pl>
	<20090215164456.34aef7e8@infradead.org>
	<1234750360.26036.115.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1234750360.26036.115.camel@pasglop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Swetland <swetland@google.com>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, mark@smtp1.linux-foundation.org, Brian@smtp1.linux-foundation.org, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 16 Feb 2009 13:12:40 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Sun, 2009-02-15 at 16:44 -0800, Arjan van de Ven wrote:
> > On Mon, 16 Feb 2009 00:10:15 +0100
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > 
> > > Hi,
> > > 
> > > The recent descussion about the Android PM patches sent by Arve
> > > shows that there is a need to introduce a mechanism allowing us
> > > to: (1) automatically put the system as a whole into a sleep
> > > state (eg. suspend to RAM) when it is found to be "idle", where
> > > the meaning of "idle" has to be defined too,
> > > (2) put given subset of devices into low power states whenever
> > > they are not used, without putting the entire system into a sleep
> > > state.
> > 
> > 
> > For (2), for me the answer is very obvious:
> 
>  .../...
> 
> I agree with pretty much everything Arjan wrote here.
> 
> > Userland should never ever control the state of a device like this
> > directly. It should do so by a) closing the device and b) setting
> > latency / functional requirements
> 
> With the possible exception of things like wifi/bt killswitch 

this is a functional switch; but yeah it is a little bit of an odd-one
out. rfkill is also not REALLY for power, it's more for FAA stuff.

>or
> network or similar where the driver cannot shut the device down
> without losing the ability to detect activity (ie, switch your PHY
> off is nice but you lose the ability to monitor the link for example).

what this needs is a separation between "interface down, all off" and
"interface down enough so that link detection works".
Some NICs can go all the way down and still do link detection, others
cannot. This is obviously something the driver will know, nothing else
in the system should know.

> 
> Cheers,
> Ben.
> 


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
