From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 20:22:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606152017240.5498@g5.osdl.org>
References: <Pine.LNX.4.64.0606141042260.5498@g5.osdl.org>
	<1150420537.7725.66.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606151839440.5498@g5.osdl.org>
	<200606161250.05076.ncunningham@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200606161250.05076.ncunningham@linuxmail.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org



On Fri, 16 Jun 2006, Nigel Cunningham wrote:
> >
> > You don't _need_ to save a consistent system image. There's no "single
> > snapshot in time" needed.
> =

> Yes, you do. If you save an image that has, say, pages in the lru that ar=
e =

> also in the free lists or a similar situation with driver data, you're go=
ing =

> to get an oops some time after resume at best, and possibly ruin your =

> filesystem at worst.

Absolutely. I've acknowledged this several times. But that's not a "device =

state" thing, that's a MM state thing. =


I 100% agree that we must have a consistent image of free memory after =

resume. That's not in question at all. What I dispute is that this is =

"device state" and has anything to do with suspending devices..

The fact that this only affects STD and not STR should make people realize =

that it's not a "device" issue. STR suspends/resumes devices too, so if =

STR doesn't have that issue, then clearly it's not actually tied to the =

notion of device suspend/resume per se. =


It's really not at all different from _any_ memory allocation after the =

start of writing the image to memory, is it?

		Linus
