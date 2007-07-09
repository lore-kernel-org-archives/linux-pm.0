From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: malicious filesystems (was Re: Re: [PATCH] Remove
	process freezer from suspend to RAM pathway)
Date: Mon, 09 Jul 2007 11:40:19 +0200
Message-ID: <E1I7pj9-0001TE-00@dorka.pomaz.szeredi.hu>
References: <200707050858.03638.oliver@neukum.org>
	<200707082307.15616.rjw@sisk.pl>
	<E1I7pXr-0001Qn-00@dorka.pomaz.szeredi.hu>
	<200707091136.33581.oliver@neukum.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200707091136.33581.oliver@neukum.org> (message from Oliver
	Neukum on Mon, 9 Jul 2007 11:36:32 +0200)
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: oliver@neukum.org
Cc: mjg59@srcf.ucam.org, miklos@szeredi.hu, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> > In that case the "we need suspend to be invisible to userspace" as a
> > reason to use the freezer would also be moot, since if you don't
> > schedule userspace after offlining the CPUs, it can't notice this.
> 
> After? Can you do the offlining atomically?

Don't know.  Wait for all CPUs to reach a scheduling point and then
take them offline?  Doesn't sound too difficult.

Miklos
