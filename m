From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFD] Automatic suspend
Date: Fri, 27 Feb 2009 16:22:19 +0100
Message-ID: <200902271622.25141.oliver__2423.09234240583$1235748016$gmane$org@neukum.org>
References: <200902191356.53584.rjw@sisk.pl>
	<200902231504.27879.oliver@neukum.org>
	<20090227101818.GH4582@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090227101818.GH4582@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Am Freitag 27 Februar 2009 11:18:18 schrieb Pavel Machek:
> > We can just as well have a class of tasks less important than power
> > saving. They'd just run when power saving is not active for some other
> > reason. Just like other such schemes we end up with the problem
> > of priority inversion with locking.
>
> Ok, I guess this could be interesting in some cases... maybe. What are
> real examples of such tasks?

The classical example is Seti@HOME. Any monitoring tool like umtsmon
or kwifimanager.

	Regards
		Oliver
