From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Wed, 29 Apr 2009 15:52:14 -0700
Message-ID: <d6200be20904291552i330ef645ib80b4473541fc4f@mail.gmail.com>
References: <1239759692-28617-1-git-send-email-arve@android.com>
	<d6200be20904202144u4c7d199fq9c0bb20f67c94d38@mail.gmail.com>
	<20090424205940.GA10735@elf.ucw.cz> <200904292324.18459.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200904292324.18459.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 29, 2009 at 2:24 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday 24 April 2009, Pavel Machek wrote:
>> Hi!
>>
>> > >> @@ -392,6 +393,9 @@ static void suspend_finish(void)
>> > >>
>> > >>
>> > >> =A0static const char * const pm_states[PM_SUSPEND_MAX] =3D {
>> > >> +#ifdef CONFIG_SUSPEND_BLOCK
>> > >> + =A0 =A0 [PM_SUSPEND_ON] =A0 =A0 =A0 =A0 =3D "on",
>> > >> +#endif
>> > >> =A0 =A0 =A0 [PM_SUSPEND_STANDBY] =A0 =A0=3D "standby",
>> > >> =A0 =A0 =A0 [PM_SUSPEND_MEM] =A0 =A0 =A0 =A0=3D "mem",
>> > >> =A0};
>> > >
>> > > This allows you to write "on" to the other interfaces where that mak=
es
>> > > no sense.... right?
>> >
>> > state_store starts iterating at PM_SUSPEND_STANDBY, so don't think so.
>>
>> Good.
>>
>>
>> > >> +bool suspend_is_blocked(void)
>> > >> +{
>> > >> + =A0 =A0 if (WARN_ONCE(!enable_suspend_blockers, "ignoring suspend=
 blockers\n"))
>> > >> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> > >> + =A0 =A0 return !!atomic_read(&suspend_block_count);
>> > >> +}
>> > >
>> > > Yes, if enable_suspend_blockers is one, we are in deep trouble.
>> >
>> > It just means that you compiled suspend blocker support into the
>> > kernel, but used an old interface to enter suspend. It warns if
>> > enable_suspend_blockers is 0 not 1.
>>
>> I do not think WARN_ONCE() should be that easy to trigger. WARN is
>> very scary animal; better use normal printk?
>
> Yes, printk() please.

Using printk instead of WARN_ONCE would be much more verbose, so I
removed it instead.

>
>> > >> +/**
>> > >> + * suspend_blocker_init() - Initialize a suspend blocker
>> > >> + * @blocker: The suspend blocker to initialize.
>> > >> + * @name: =A0 =A0The name of the suspend blocker to show in
>> > >> + * =A0 =A0 =A0 =A0 =A0 /proc/suspend_blockers
>> > >
>> > > I don't think suspend_blockers should go to /proc. They are not proc=
ess-related.
>> >
>> > I moved that comment to the stats patch. It is still in procfs though,
>> > as it is most similar to other procfs entries. It is not allowed under
>> > the sysfs rules, and we do not want to enable debugfs on a production
>> > system since it exposes some unsafe interfaces.
>>
>> You have to sort this out somehow. It does not belong to /proc.
>
> Agreed.

OK. I moved it to debugfs.

-- =

Arve Hj=F8nnev=E5g
