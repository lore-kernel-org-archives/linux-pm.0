From: "Amit Kucheria" <kucheria.amit@gmail.com>
Subject: Re: Ottawa Linux Power Management Summit
Date: Tue, 15 May 2007 01:36:30 +0300
Message-ID: <52d486620705141536s513a92d5w192ab318b984b11@mail.gmail.com>
References: <200705112313.54744.lenb@kernel.org>
	<20070512223359.GB720@elf.ucw.cz> <200705141638.41722.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705141638.41722.lenb@kernel.org>
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
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 5/14/07, Len Brown <lenb@kernel.org> wrote:
> On Saturday 12 May 2007 18:33, Pavel Machek wrote:
> > Hi!
> >
> > > I'd like to conduct a Linux Power Management Summit
> > > during the two days preceeding the Ottawa Linux Symposium:
> > >
> > > Monday June 25
> > > Tuesday June 26
> > >
> > > Hopefully the session can benefit from some of the lessons learned
> > > by the Storage Summit folks -- according to James they include:
> > >
> > > 1. round-table format -- discussion oriented, limited presentations.
> > > 2. limit to ~20 attendees to support discussion format
> > > 3. prepare agenda and topic list by consensus via e-mail ahead of time.
> > >
> > > Please let me know what you think should be on the agenda,
> > > and if you are motivated to show up for the discussion.

Here are a few things that have been tossed around for a while on
linux-pm and CELF that should be discussed:

1. Unified interface to dynamic/runtime PM for laptop/server and
embedded platforms - Does it make sense?
2. Enhancements to Linux driver model to handle dynamic PM
3. Where should policy be located? Drivers or userspace or a mix of both?
4. Interfaces to userspace policy manager
5. Can x86 device drivers and bus drivers do more runtime PM? Similar
to some of the USB work being carried on by Alan/David.
6. What can be done to ensure Suspend To RAM _always_ works? Video
drivers are the big problem now, anything else?
7. Using wakeup latency as a parameter to decide how deep we want to sleep

As someone pointed out, it would be nice to see the results of this at
the PM BOF or even covered by LWN.

Regards,
Amit

--
Amit Kucheria, Embedded developer
