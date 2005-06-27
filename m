From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Suspend "core": what to do now ?
Date: Mon, 27 Jun 2005 23:23:31 +0200
Message-ID: <20050627212330.GB7278@atrey.karlin.mff.cuni.cz>
References: <1119851395.5133.112.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============42249835487115028=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1119851395.5133.112.camel@gaston>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============42249835487115028==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> So I'm still sitting on that rewrite of the pmac suspend code including
> suspend to disk consolidation etc... that I would really like to get
> upstream. However, I'm still having a problem:
> 
>  - I'm still adding all those callbacks to pm_ops, Patrick wants to get
> the stuff out of the core, which I agree, but I don't feel like "fixing"
> x86 neither :) Pavel wants to keep the existing stuff.

I'm currently on the "vacation" (lingvistic conference); away from
x86-64 machines. I'm likely to accept any solution that is not uglyer
than current situation, but you'll either have to convert x86{,-64}
yourself, or wait... probably until Ottawa. I'll be out next week, and
then probably overloaded with pushing my patches and getting Canadian
visa.

>  - If I keep my callbacks addition, we need to consolidate
> kernel/power/disk.c with kernel/power/main.c. I need all callbacks in
> both cases. The current inconsistency makes little sense.

Yep, disk.c/main.c separation makes little sense.

>  - I want that in 2.6.13 final, so please, let's decide something :)

Start getting x86-64 machine, then ;-)))))). Or force ppc into current
infrastructure somehow.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.

--===============42249835487115028==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============42249835487115028==--
