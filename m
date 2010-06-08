From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: suspend blockers & Android integration
Date: Mon, 7 Jun 2010 17:05:32 -0700
Message-ID: <AANLkTimWasxjM5wGu6fypktpdidFkvccd8202XqrRX12__42521.0529858761$1275955620$gmane$org@mail.gmail.com>
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
	<alpine.LFD.2.00.1006061236350.2933@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1006061236350.2933@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: tytso@mit.edu, Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

2010/6/6 Thomas Gleixner <tglx@linutronix.de>:
> On Sat, 5 Jun 2010, Arve Hj=F8nnev=E5g wrote:
>> 2010/6/5 Thomas Gleixner <tglx@linutronix.de>:
>> >
>> > Can you please explain in a consistent way how the application stack
>> > and the underlying framework (which exists according to android docs)
>> > is handling events and how the separation of trust level works ?
>> >
>>
>> I don't think I can, since I only know small parts of it. I know some
>
> Sigh, thats the whole reason why this discussion goes nowhere.
>

Please keep in mind that we also have third party applications and
that it is not acceptable to break them. So even if I was able to tell
you everything our framework does, you still need to make sure your
solution does not break existing apps.

> How in heavens sake should we be able to decide whether suspend
> blockers are the right and only thing which solves a problem, when the
> folks advocating suspend blockers are not able to explain the problem
> in the first place ?
>
>> events like input event go though a single thread in our system
>> process, while other events like network packets (which are also
>> wakeup events) goes directly to the app.
>
> Yes, we know that already, but that's a completely useless information
> as it does not describe the full constraints and dependencies.
>
> Lemme summarize:
>
> =A0Android needs suspend blockers, because it works, but cannot explain
> =A0why it works and why it only works that way.
>
> A brilliant argument to merge them - NOT.
>

Your solution changes the programming model in a way that suspend does
not. Linux allow processes to communicate with each other, and if you
freeze individual processes this breaks. For the android framework
code a lack of a timely response from an application is treated as an
error, and the user is notified that the application is misbehaving.
It may be possible to change the framework to make sure that no
processes are frozen while it is waiting for a response, but this is a
major change and applications that receive wakeup events directly from
the kernel will still be broken.

-- =

Arve Hj=F8nnev=E5g
