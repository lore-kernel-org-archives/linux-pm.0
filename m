From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFD] Automatic suspend
Date: Mon, 16 Feb 2009 07:40:48 -0800
Message-ID: <20090216074048.6d70f17c__9240.9785757356$1234799023$gmane$org@infradead.org>
References: <200902160010.16955.rjw@sisk.pl>
	<1234750360.26036.115.camel@pasglop>
	<20090215182012.3bc6b292@infradead.org>
	<200902160806.17901.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902160806.17901.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Matthew@smtp1.linux-foundation.org, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 16 Feb 2009 08:06:13 +0100
Oliver Neukum <oliver@neukum.org> wrote:

> Am Monday 16 February 2009 03:20:12 schrieb Arjan van de Ven:
> > >or
> > > network or similar where the driver cannot shut the device down
> > > without losing the ability to detect activity (ie, switch your PHY
> > > off is nice but you lose the ability to monitor the link for
> > > example).
> > 
> > what this needs is a separation between "interface down, all off"
> > and "interface down enough so that link detection works".
> > Some NICs can go all the way down and still do link detection,
> > others cannot. This is obviously something the driver will know,
> > nothing else in the system should know.
> 
> Why shouldn't user space know the consequences of still requesting
> a service and be able to decide on that basis which services to
> request?

That's not what I said. Userspace should not be the part that goes "oh
this is a realtek not an intel nic, so ..."
That is the drivers job.

Userspace should just be the part that says "I'm interested in link
notifications". The driver then just goes to the lowest power state for
its device that still gives those notifications.


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
