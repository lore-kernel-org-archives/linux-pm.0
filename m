From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFD] Automatic suspend
Date: Tue, 17 Feb 2009 00:20:12 +0100
Message-ID: <200902170020.15509.oliver__40396.0389354781$1234826563$gmane$org@neukum.org>
References: <200902160010.16955.rjw@sisk.pl>
	<200902161748.09208.oliver@neukum.org>
	<20090216093108.078aac35@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090216093108.078aac35@infradead.org>
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
To: Arjan van de Ven <arjan@infradead.org>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Am Monday 16 February 2009 18:31:08 schrieb Arjan van de Ven:
> On Mon, 16 Feb 2009 17:48:06 +0100
> Oliver Neukum <oliver@neukum.org> wrote:
> 
> > > Userspace should just be the part that says "I'm interested in link
> > > notifications". The driver then just goes to the lowest power state
> > > for its device that still gives those notifications.
> > 
> > Should there be a channel through which drivers can tell user space
> > what the consequences in terms of reaching a sleep state are if a
> > service is requested?
> 
> Personally, I don't think so.
> Think about it: what would userspace do?
> Not ask for the functionality if it means no sleep state?
> Maybe it should just never ask for it then as a required functionality!

1. You may have a human being using the information to make the tradeoff.
2. User space may be able to select among several devices the one cheapest
to use

	Regards
		Oliver
