From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFD] Automatic suspend
Date: Mon, 16 Feb 2009 08:06:13 +0100
Message-ID: <200902160806.17901.oliver__39971.9091285535$1234768024$gmane$org@neukum.org>
References: <200902160010.16955.rjw@sisk.pl>
	<1234750360.26036.115.camel@pasglop>
	<20090215182012.3bc6b292@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090215182012.3bc6b292@infradead.org>
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

Am Monday 16 February 2009 03:20:12 schrieb Arjan van de Ven:
> >or
> > network or similar where the driver cannot shut the device down
> > without losing the ability to detect activity (ie, switch your PHY
> > off is nice but you lose the ability to monitor the link for example).
> 
> what this needs is a separation between "interface down, all off" and
> "interface down enough so that link detection works".
> Some NICs can go all the way down and still do link detection, others
> cannot. This is obviously something the driver will know, nothing else
> in the system should know.

Why shouldn't user space know the consequences of still requesting
a service and be able to decide on that basis which services to request?

	Regards
		Oliver
