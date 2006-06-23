From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Fri, 23 Jun 2006 10:08:51 +1000
Message-ID: <1151021331.4046.76.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606210937090.5498@g5.osdl.org>
	<1150938119.16303.99.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606211844590.5498@g5.osdl.org>
	<1150946286.947.50.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606212105220.5498@g5.osdl.org>
	<1150952298.3633.20.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606220909220.5498@g5.osdl.org>
	<1151014893.4046.24.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606221527590.6483@g5.osdl.org>
	<1151017911.4046.55.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606221614280.6483@g5.osdl.org>
	<1151019097.4046.69.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606221636210.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606221636210.6483@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thu, 2006-06-22 at 16:41 -0700, Linus Torvalds wrote:
> =

> On Fri, 23 Jun 2006, Benjamin Herrenschmidt wrote:
> > > =

> > > So you say. Have you actually ever done anything to make debugging ea=
sier?
> > =

> > I've implemented suspend/resume for a whole range of machiens where
> > everything goes down and all I have to debug on resume is ... sending
> > commands to a chip to blink a LED. So yes, I have.
> =

> That's not what I asked.
> =

> I didn't ask whether you had debugged suspend/resume.
>
> I asked whether you had tried to make it easier.

Yes and I've given you examples later in the same email. The main one
being that early resume console thing. And yes, I did it in an arch
specific way, because there was no way I could resume the display _that_
early in a general case, and yes, I think it might be interesting to
think about doing the general case still (though the main problem will
be the resuming of AGP which currently =

tends to not follow any correct ordering rule vs. the video chip on the
bus).

Ben.
