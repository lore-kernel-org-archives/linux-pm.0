From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: Suspend "core": what to do now ?
Date: Tue, 28 Jun 2005 00:39:05 +0200
Message-ID: <200506280039.05972.rjw@sisk.pl>
References: <1119851395.5133.112.camel@gaston>
	<20050627212330.GB7278@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============39007407841780983=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050627212330.GB7278@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============39007407841780983==
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Monday, 27 of June 2005 23:23, Pavel Machek wrote:
> Hi!
> 
> > So I'm still sitting on that rewrite of the pmac suspend code including
> > suspend to disk consolidation etc... that I would really like to get
> > upstream. However, I'm still having a problem:
> > 
> >  - I'm still adding all those callbacks to pm_ops, Patrick wants to get
> > the stuff out of the core, which I agree, but I don't feel like "fixing"
> > x86 neither :) Pavel wants to keep the existing stuff.
> 
> I'm currently on the "vacation" (lingvistic conference); away from
> x86-64 machines. I'm likely to accept any solution that is not uglyer
> than current situation, but you'll either have to convert x86{,-64}
> yourself, or wait... probably until Ottawa. I'll be out next week, and
> then probably overloaded with pushing my patches and getting Canadian
> visa.
> 
> >  - If I keep my callbacks addition, we need to consolidate
> > kernel/power/disk.c with kernel/power/main.c. I need all callbacks in
> > both cases. The current inconsistency makes little sense.
> 
> Yep, disk.c/main.c separation makes little sense.
> 
> >  - I want that in 2.6.13 final, so please, let's decide something :)
> 
> Start getting x86-64 machine, then ;-)))))). Or force ppc into current
> infrastructure somehow.

I think I'll be able to help in a couple of days.  Then I can take care of the
x86-64 stuff, possibly with some assistance of someone more
knowledgeable. ;-)

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--===============39007407841780983==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============39007407841780983==--
