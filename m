From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Hibernation considerations
Date: Tue, 17 Jul 2007 22:58:33 +0200
Message-ID: <200707172258.35113.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0707171010490.3551-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0707171302430.2467@asgard.lang.hm>
	<87k5syg3yi.fsf@jbms.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87k5syg3yi.fsf@jbms.ath.cx>
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
To: Jeremy Maitin-Shepard <jbms@cmu.edu>
Cc: david@lang.hm, LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Al Boldi <a1426z@gawab.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 17 July 2007 22:39, Jeremy Maitin-Shepard wrote:
> david@lang.hm writes:
> 
> [snip]
> 
> > the non-ACPI hibernate behaves very differently, and for some people (and I
> > think I am one of them) it will meet their needs better then _any_ of the ACPI
> > suspends.
> 
> It may have certain differences from the user point of view, but from
> the implementation view, it seems that it is nearly exactly the same.
> The only differences seem to be: 
> 
>  - rather than shutting down, do whatever is necessary to stick the
>    system in S4 state.
> 
>  - make sure ACPI isn't initialized by the "load image" kernel
> 
>  - rather than "resume from hibernate" ACPI by initializing it normally,
>    issue the special hibernate-related methods.
> 
> Thus, it seems that supporting ACPI S4 will have a very minimal affect
> on the hibernate implementation.

Still, you need to take it into account.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
