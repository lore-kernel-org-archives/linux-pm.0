From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: freeze_processes questions
Date: Wed, 6 Apr 2005 00:46:17 +0200
Message-ID: <200504060046.18159.rjw@sisk.pl>
References: <200504051120.44496.rjw@sisk.pl> <200504052002.30245.rjw@sisk.pl>
	<20050405203753.GC1380@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============60736352858363474=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050405203753.GC1380@elf.ucw.cz>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============60736352858363474==
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Tuesday, 5 of April 2005 22:37, Pavel Machek wrote:
]--snip--[ 
> > 2) We can try to force uninterruptible tasks to get their "signals" anyway using
> > wake_up_state() directly on them (which I don't like as much).
> 
> They are probably uninterruptible for a reason...
> 
> If something is staying in UNINTERRUPTIBLE for more than 1 second, it
> is going to cause problems elsewhere, anyway. Do you see that happening?

Probably.  Please see, for example, this message sent to l-k:

http://marc.theaimsgroup.com/?l=linux-kernel&m=111268969510393&w=2

I can easily trigger a similar behavior with an uninterruptible task and I
have some problems with freezing tasks on SMP that smell like this too.

If we are going to ignore uninterruptible tasks, I'd propose to set PF_FREEZE
and TIF_SIGPENDING for them without counting them as "todo" in
freeze_processes() (if such a task is woken up afterwards by an interrupt
handler, it'll get the "signal" and it'll go to the refrigerator() immediately,
because of the PF_FREEZE).  At least, I'd do this on resume, as we don't care
for these tasks then anyway and IMHO it's not a good idea to fail because of
them.

I think we should also clear PF_FREEZE for uninterruptible tasks in
thaw_processes(), just in case. :-)

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--===============60736352858363474==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============60736352858363474==--
