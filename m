From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFD] Automatic suspend
Date: Tue, 17 Feb 2009 11:12:59 +0100
Message-ID: <200902171113.02114.oliver__2376.4420919635$1234865880$gmane$org@neukum.org>
References: <f73f7ab80902161208h12837d4ex1d28d55d031d5d71@mail.gmail.com>
	<200902170019.40599.rjw@sisk.pl>
	<20090216232329.GA15678@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090216232329.GA15678@srcf.ucam.org>
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

Am Tuesday 17 February 2009 00:23:30 schrieb Matthew Garrett:
> On Tue, Feb 17, 2009 at 12:19:38AM +0100, Rafael J. Wysocki wrote:
> 
> > This, again, seems to be a bit x86-centric. :-)  The Android people are telling
> > us that on the hardware they deal with it does make sense to put the entire
> > system to sleep even for relatively short periods of time, since the latencies
> > involved are not too bad.
> 
> Arve said that the power state was equivalent in idle and suspend, but 
> that they preferred suspend because it stopped any periodic timers. I'd 
> be more interested in making sure that unnecessary timers aren't running 
> than focusing on automatically entering system-wide suspend - Nokia have 
> been managing this since 2005 with good results.

I agree. For a general purpose system it would be very hard to call
some timers unnecessary and others necessary.

	Regards
		Oliver
