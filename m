From: Jeremy Maitin-Shepard <jbms@cmu.edu>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 05 Jul 2007 23:59:00 -0400
Message-ID: <87d4z6xjwb.fsf__16572.2900339917$1183694496$gmane$org@jbms.ath.cx>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<20070705115400.GF3984@ucw.cz>
	<E1I6Q73-0000Xi-00@dorka.pomaz.szeredi.hu>
	<200707052138.56920.oliver@neukum.org>
	<E1I6XFM-0001ek-00@dorka.pomaz.szeredi.hu>
	<1183676751.3388.96.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1183676751.3388.96.camel@localhost.localdomain> (Benjamin
	Herrenschmidt's message of "Fri\, 06 Jul 2007 09\:05\:51 +1000")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: mjg59@srcf.ucam.org, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

[snip]

> At the end of the day, I stand my ground, the freezer cannot be made
> reliable without massive infrastructure changes or giving up on very
> useful features such as fuse among others. Besides, it only partially
> "hides" the problem of requests going to drivers, thus it's a bad
> solutions.

I agree that the freezer absolutely should not be used for suspend to
ram ("suspend"), since it is unnecessary with properly written drivers,
which are important to have anyway.  It seems that it is indeed the
consensus that it will be phased out sooner or later.

It does seem that the current device suspend interface does not tell the
drivers enough, since as discussed, they need to know whether to merely
block if they receive a request while suspended (as should be done while
initiating a suspend to ram), or if they should wake up the device (as
should be done if a suspend to ram is not in progress).  Clearly these
two cases need to be addressed by every driver supporting suspend/resume
(but possibly indirectly if the subsystem handles it for them).

The current hibernate approach used by all of the existing
implementations for Linux seems to depend fundamentally on the freezer,
though, in order to actually save the system state.  Thus, it will still
be necessary to fix all of the issues with the freezer, or adopt an
alternate hibernate approach (which is unlikely).  Unfortunately, even
leaving kernel threads and certain drivers running after the snapshot is
taken means that the saved image isn't completely correct, and the
freezer cannot help with these issues.

[snip]

-- 
Jeremy Maitin-Shepard
