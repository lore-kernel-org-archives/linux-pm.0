From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFD] Automatic suspend
Date: Mon, 16 Feb 2009 17:48:06 +0100
Message-ID: <200902161748.09208.oliver__45264.5328281962$1234803022$gmane$org@neukum.org>
References: <200902160010.16955.rjw@sisk.pl>
	<200902160806.17901.oliver@neukum.org>
	<20090216074048.6d70f17c@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090216074048.6d70f17c@infradead.org>
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

Am Monday 16 February 2009 16:40:48 schrieb Arjan van de Ven:
> > Why shouldn't user space know the consequences of still requesting
> > a service and be able to decide on that basis which services to
> > request?
> 
> That's not what I said. Userspace should not be the part that goes "oh
> this is a realtek not an intel nic, so ..."
> That is the drivers job.

True.

> Userspace should just be the part that says "I'm interested in link
> notifications". The driver then just goes to the lowest power state for
> its device that still gives those notifications.

Should there be a channel through which drivers can tell user space
what the consequences in terms of reaching a sleep state are if a service
is requested?

	Regards
		Oliver
