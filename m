From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [Update][PATCH 7/8] PM / Domains: System-wide
 transitions support for generic domains (v3)
Date: Thu, 23 Jun 2011 14:22:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106231421470.2033-100000__45892.4367245801$1308856386$gmane$org@iolanthe.rowland.org>
References: <201106231941.09429.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106231941.09429.rjw@sisk.pl>
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
Cc: linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 23 Jun 2011, Rafael J. Wysocki wrote:

> > It should say "system suspend" rather than "system sleep".
> 
> It says "system sleep" to distinguish between the state of the system
> ("system sleep") and the operation leading to that state ("system suspend").
> That terminology is used all over the document, so I don't think it's a good
> idea to change it just for this specific paragraph.
> 
> I agree that "suspend" should be used where it talks about starting, stopping
> etc.
> 
> > Then to drive the point home, the following sentence chould say 
> > something like this:
> > 
> > If that is the case and none of the situations listed above takes place
> > (in particular, if the system is waking up from suspend and not from
> > hibernation), it may be more efficient to leave the devices that had
> > been suspended before the system suspend began in the suspended state.
> 
> That's fine by me, except that I'd simply say "(in particular, if the system
> is not waking up from hibernation)".

Okay.

Alan Stern
