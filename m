From: Pavel Machek <pavel@ucw.cz>
Subject: Re: freeze_processes questions
Date: Wed, 6 Apr 2005 00:57:51 +0200
Message-ID: <20050405225751.GA1353@elf.ucw.cz>
References: <200504051120.44496.rjw@sisk.pl> <200504052002.30245.rjw@sisk.pl>
	<20050405203753.GC1380@elf.ucw.cz> <200504060046.18159.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============65547785700141237=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200504060046.18159.rjw@sisk.pl>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============65547785700141237==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > 2) We can try to force uninterruptible tasks to get their "signals" anyway using
> > > wake_up_state() directly on them (which I don't like as much).
> > 
> > They are probably uninterruptible for a reason...
> > 
> > If something is staying in UNINTERRUPTIBLE for more than 1 second, it
> > is going to cause problems elsewhere, anyway. Do you see that happening?
> 
> Probably.  Please see, for example, this message sent to l-k:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111268969510393&w=2

...hmm, perhaps kseriod needs suspend/resume support, or something;
but that does not mean we should handle *all* uninterruptible tasks
that way.

> I can easily trigger a similar behavior with an uninterruptible task and I
> have some problems with freezing tasks on SMP that smell like this too.
> 
> If we are going to ignore uninterruptible tasks, I'd propose to set PF_FREEZE
> and TIF_SIGPENDING for them without counting them as "todo" in

You can't just ignore uninterruptible tasks, sorry.

OTOH, if you want working refrigerator, Nigel has one ;-). We were
talking about merging it to mainline few times already...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--===============65547785700141237==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============65547785700141237==--
