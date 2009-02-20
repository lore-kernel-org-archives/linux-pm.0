From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFD] Automatic suspend
Date: Fri, 20 Feb 2009 21:49:24 +0100
Message-ID: <200902202149.25990.rjw__26696.2690781385$1235163192$gmane$org@sisk.pl>
References: <f73f7ab80902161208h12837d4ex1d28d55d031d5d71@mail.gmail.com>
	<20090220182213.GA1681@ucw.cz>
	<20090220182609.GA3289@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090220182609.GA3289@srcf.ucam.org>
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
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Friday 20 February 2009, Matthew Garrett wrote:
> On Fri, Feb 20, 2009 at 07:22:15PM +0100, Pavel Machek wrote:
> >  On Mon 2009-02-16 23:23:30, Matthew Garrett wrote:
> > > On Tue, Feb 17, 2009 at 12:19:38AM +0100, Rafael J. Wysocki wrote:
> > > 
> > > > This, again, seems to be a bit x86-centric. :-)  The Android people are telling
> > > > us that on the hardware they deal with it does make sense to put the entire
> > > > system to sleep even for relatively short periods of time, since the latencies
> > > > involved are not too bad.
> > > 
> > > Arve said that the power state was equivalent in idle and suspend, but 
> > 
> > ...for Arve's hardware. Not all embedded systems are like that, and
> > OLPC / PCs are definitely not like that.
> 
> And PCs have enough latency over suspend/resume that we can't do it 
> automatically in a non-intrusive manner anyway, so runtime pm is more 
> interesting there as well.

Agreed.

Thanks,
Rafael
