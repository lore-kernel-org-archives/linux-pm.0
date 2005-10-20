From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: 2.6.14-rc4-mm1: USB suspend regression (was: Re:
 2.6.14-rc1-mm1: usb breaks suspend)
Date: Thu, 20 Oct 2005 11:30:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0510201122290.4977-100000@iolanthe.rowland.org>
References: <200510200016.26197.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============20583076750273666=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200510200016.26197.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, USB development list <linux-usb-devel@lists.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

--===============20583076750273666==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 20 Oct 2005, Rafael J. Wysocki wrote:

> Hi,
> 
> On Wednesday, 19 of October 2005 22:46, Alan Stern wrote:
> > On Wed, 19 Oct 2005, Rafael J. Wysocki wrote:
> }-- snip --{
> > There has been a lot of development on USB  
> > suspend/resume in 2.6.14, and you don't have all the patches applied.  In 
> > particular, you are missing usb-pm-05.patch (probably a bunch of others as 
> > well).
> 
> If I'm missing any patches that's becasue they are not in 2.6.14-rc4-mm1
> for some reason (I assume an important one).

You'll have to get the details from Greg.  The stuff in his tree generally 
does end up in -mm after only a short delay, but maybe some patches get 
lost somehow.  Or maybe some of them didn't make it in time for -mm1.

> > Take my advice: Start from 2.6.14-rc4, apply gregkh-all-2.6.14-rc4.patch 
> > (it gets updated fairly often, so retrieve a fresh copy), and also apply 
> > the PF_NOFREEZE patch (as585) I posted on lkml and linux-pm.
> 
> From my POV this means there's no point in testing USB suspend/resume
> on 2.6.14-rc4-mm1, because it's potentially broken.  Which is fair enough,
> BTW.

If 2.6.14-rc4-mm1 still has hub_suspend and hub_resume preprocessed away,
then you're right -- it's too old to be worth testing.

> > > I've figured out that too.  However, if something has no _suspend() routine,
> > > verify_suspended() could return 0 for it, I think, instead of -EBUSY.
> > 
> > Dave Brownell would probably give you an argument, but I tend to agree.  
> > Alternatively, if something has no ->suspend then we could just set its 
> > ->power.power_state value directly so it would _appear_ to be suspended.
> 
> Well, that depends.  If the driver has a _resume() routine, it's ->power.power_state
> should be set on suspend.  However, if it has neither _resume() nor _suspend(),
> it's ->power.power_state is not really well defined, so it's just easier to ignore it.

I don't want to change this without talking to Dave first, and
unfortunately he's incommunicado at the moment.  Wasn't it Groucho Marx
who said that "communicado" was a small country in Latin America?  In
Dave's case the country isn't so small (Brazil) and all the emails
I've sent him in the last few days have bounced.  So we'll have to wait 
until he gets back and straightens things out with his service provider.

Alan Stern


--===============20583076750273666==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============20583076750273666==--
