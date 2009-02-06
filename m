From: Uli Luckas <u.luckas@road.de>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Fri, 6 Feb 2009 10:45:21 +0100
Message-ID: <200902061045.21872.u.luckas@road.de>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<20090205091132.GG2077@elf.ucw.cz>
	<d6200be20902051628x50827a27i52c4b69cc64585f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20902051628x50827a27i52c4b69cc64585f7@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: ncunningham@crca.org.au, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday, 6. February 2009, Arve Hj=F8nnev=E5g wrote:
> On Thu, Feb 5, 2009 at 1:11 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > On Wed 2009-02-04 18:50:14, Arve Hj??nnev??g wrote:
> >> +A locked wakelock, depending on its type, prevents the system from
> >> entering +suspend or other low-power states. When creating a wakelock,
> >> you can select +if it prevents suspend or low-power idle states.  If t=
he
> >> type is set to
> >
> > idle states are very different from suspend. Mixing them does not look
> > like good idea... and IIRC we already have API somewhere to prevent
> > deep idle states. Intel did it for their wireless cards IIRC.
>
> If you are talking about the pm_qos interface, then yes there is some
> overlap. We did not use the pm_qos interface since it does a linear
> scan for a string every time you change a requirement, and it only let
> you specify the latency you need not the power level. We have
> interrupts that stop working at the lowest power level and this does
> not easily translate into a latency value.
>
> >> +                 Key pressed   Key released
> >> +                     |             |
> >> +keypad-scan          ++++++++++++++++++
> >> +input-event-queue        +++          +++
> >> +process-input-events       +++          +++
> >> +
> >
> > I'm not sure if keyboard scanning example is good here. It is very
> > t-mobile G1 specific.
>
> There is no G1 specific code in the keypad driver. I also don't
> remember seeing any development boards without a similar keypad. I
> like this example since it show how an event can be passed from the
> kernel to user-space.
>
I absolutely agree. The example shows how you can keep wake locks right fro=
m =

the time the interrupt comes in through all levels until a user space actio=
n =

gets triggered.

Uli

-- =


------- ROAD ...the handyPC Company - - -  ) ) )

Uli Luckas
Head of Software Development

ROAD GmbH
Bennigsenstr. 14 | 12159 Berlin | Germany
fon: +49 (30) 230069 - 62 | fax: +49 (30) 230069 - 69
url: www.road.de

Amtsgericht Charlottenburg: HRB 96688 B
Managing director: Hans-Peter Constien
