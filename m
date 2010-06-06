From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: suspend blockers & Android integration
Date: Sun, 6 Jun 2010 12:56:59 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1006061236350.2933__21402.8304246769$1275821888$gmane$org@localhost.localdomain>
References: <20100603193045.GA7188@elte.hu> <20100603232302.GA16184@elte.hu>
	<1275644619.27810.39462.camel@twins>
	<201006050138.30859.rjw@sisk.pl>
	<alpine.LFD.2.00.1006050148080.2933@localhost.localdomain>
	<AANLkTikGDSzaENwg_0BAtsYf3ulGd_6sGPR30WsvUxMi@mail.gmail.com>
	<alpine.LFD.2.00.1006050246350.2933@localhost.localdomain>
	<AANLkTikU21xF49Z-_Lnrq7U7buNmqw_gyEEST8LuN24z@mail.gmail.com>
	<alpine.LFD.2.00.1006051736040.2933@localhost.localdomain>
	<AANLkTinD39rI47innPbGz1Gi8PsXV5HqkmaQuJ70oQ63@mail.gmail.com>
	<alpine.LFD.2.00.1006052348200.2933@localhost.localdomain>
	<AANLkTikmWDHYJ8wWF2cZapbkHHjV09R39I37yvQXFmor@mail.gmail.com>
	<alpine.LFD.2.00.1006060148470.2933@localhost.localdomain>
	<AANLkTikdM79nmARagK9gLveMWEiT6rlk44UELes1k8Ch@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-455178742-1275821822=:2933"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikdM79nmARagK9gLveMWEiT6rlk44UELes1k8Ch@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-15?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: tytso@mit.edu, Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-455178742-1275821822=:2933
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp1.linux-foundation.org id o56AvS8m006118

On Sat, 5 Jun 2010, Arve Hj=F8nnev=E5g wrote:
> 2010/6/5 Thomas Gleixner <tglx@linutronix.de>:
> >
> > Can you please explain in a consistent way how the application stack
> > and the underlying framework (which exists according to android docs)
> > is handling events and how the separation of trust level works ?
> >
>=20
> I don't think I can, since I only know small parts of it. I know some

Sigh, thats the whole reason why this discussion goes nowhere.

How in heavens sake should we be able to decide whether suspend
blockers are the right and only thing which solves a problem, when the
folks advocating suspend blockers are not able to explain the problem
in the first place ?

> events like input event go though a single thread in our system
> process, while other events like network packets (which are also
> wakeup events) goes directly to the app.

Yes, we know that already, but that's a completely useless information
as it does not describe the full constraints and dependencies.

Lemme summarize:

  Android needs suspend blockers, because it works, but cannot explain
  why it works and why it only works that way.

A brilliant argument to merge them - NOT.

Thanks,

	tglx
--8323328-455178742-1275821822=:2933
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--8323328-455178742-1275821822=:2933--
