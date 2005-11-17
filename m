From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [RFC] userland swsusp
Date: Thu, 17 Nov 2005 15:46:07 -0500
Message-ID: <1132260368.5959.4.camel@mindpipe>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com>
	<20051116164429.GA5630@kroah.com> <1132172445.25230.73.camel@localhost>
	<20051116220500.GF12505@elf.ucw.cz>
	<20051117170202.GB10402@dspnet.fr.eu.org>
	<1132257432.4438.8.camel@mindpipe>
	<20051117201204.GA32376@dspnet.fr.eu.org>
	<1132258855.4438.11.camel@mindpipe> <20051117203731.GG5772@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============14031388599939421=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051117203731.GG5772@redhat.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dave Jones <davej@redhat.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Olivier Galibert <galibert@pobox.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============14031388599939421==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-11-17 at 15:37 -0500, Dave Jones wrote:
> I don't know about other distros, but here's how that usually goes for Fedora users..
> 
> 1. user installs new release, and sound doesn't work.
> 2. user blames ALSA, bug gets filed against kernel.
> 3. I take a look, sometimes we get to play "ping pong the bug between
>    userspace & kernel component" for a while
> 4. I throw my hands in the air and say "tell the upstream ALSA developers"
> 5. user does so
> 6. user comes back to Fedora bugzilla with the response
>    "Alsa people told me its a Fedora bug".
> 
> So, given we ship unpatched[1] ALSA, my faith in the
> possibility of ALSA working "OOTB" is somewhat lacking.
> 
> These bugs usually sit in our bugzilla, every so often
> I'll ping them after I've rebased to a new release, and
> surprise surprise, they magically get fixed.
> (Although every release we seem to trade one set of
>  working sound drivers for a new set of broken ones).

The process would work a lot faster if the Fedora project would
contribute anything at all to ALSA development.  It's a lot of work!  I
haven't seen a line of sound driver code from anyone at Red Hat since
the OSS->ALSA transition, years ago.  Meanwhile the vendors keep getting
cheaper and cheaper, which means more functionality that used to be in
hardware has to be done in the drivers.

For example the Debian people are very helpful, they have someone who
filters out the real bug reports from their users and pushes them into
the ALSA bug tracker.  Fedora just points clueless users at the ALSA bug
tracker and tells them "good luck".

Lee


--===============14031388599939421==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============14031388599939421==--
