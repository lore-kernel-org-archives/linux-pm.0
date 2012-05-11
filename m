From: mark gross <markgross@thegnar.org>
Subject: Re: Plumbers: PM constraints micro-conf RFP
Date: Fri, 11 May 2012 07:14:31 -0700
Message-ID: <20120511141431.GB2618@G62>
References: <20120502143607.GA21640@G62>
	<CAGF5oy8E26sYHi13ayrrOY5qbXepz1U8ErEfF-Ata9k6Zyzz+Q@mail.gmail.com>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAGF5oy8E26sYHi13ayrrOY5qbXepz1U8ErEfF-Ata9k6Zyzz+Q@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Valentin, Eduardo" <eduardo.valentin@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, "Agarwal, Ramesh" <ramesh.agarwal@intel.com>, markgross@thegnar.org, paulmck@vnet.ibm.com, Praveen Chidambaram <pchidamb@gmail.com>, Amit Kucheria <amit.kucheria@linaro.org>, Antti P Miettinen <amiettinen@nvidia.com>, John Stultz <john.stultz@linaro.org>, linux-pm@lists.linux-foundation.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

On Fri, May 11, 2012 at 10:17:19AM +0300, Valentin, Eduardo wrote:
> Hello Mark,
> =

> On Wed, May 2, 2012 at 5:36 PM, mark gross <markgross@thegnar.org> wrote:
> > This is a Request For Participation in a micro-conference at this years
> > Linux plumbers event. =A0For this micro conference to happen we need to
> > reach a certain critical mass WRT participants as measured by submitted
> > talks associated to Power Management Constraints.
> =

> Nice! Thanks for proposing this.
> =

> >
> > The To: list is populated with folks that I've had interactions with
> > over extending pm-qos or constraint based PM over the past year.
> >
> > If you are working on problems related to constraining the power /
> > performance of devices I am inviting your participation and request you
> > submit a proposal for presenting your problem space (preferred) and or
> > solution to a group of developers looking for a good solution to push
> > upstream. =A0The talks will be about 20 min long as I want to get into
> > some design and implementation discussions after the requirements
> > definition is mostly finished.
> >
> > I am interested in gathering user mode interface needs as well as kernel
> > mode.
> >
> > From a high level pm-constraints is a generalization of pm-qos to inclu=
de
> > limiting performance as well as its current limiting of device
> > throttling.
> >
> > As performance limiting is typically used for any of the following:
> > 1) staying within thermal operational envelopes
> > 2) avoiding peak current
> > 3) extending battery life in active use cases
> >
> > I invite anyone working in any of these areas or pm-qos applications to
> > participate in this micro-conference.
> >
> > I will organize the micro-conference into 2 parts:
> > 1) problem statements with specific participant examples where
> > constraining the performance or throttling is needed.
> =

> =

> I could bring something on the use cases where this type of
> constraining could be used. Essentially major focus gets partitioned
> in two areas: For device skin/case temperature management, and IC's
> junction temperature management.
> =


This will be great!  Getting the common / typical use cases well
represented is the highest priority of the session IMO.

Having a solid understanding of them will drive the requirements and
hopefully make defining the architecture quick, easy and without a lot of
conflicting points of view.

--mark
