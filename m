From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm][Experimental] swsusp: freeze
	userspace processes first
Date: Wed, 1 Feb 2006 13:49:50 +0100
Message-ID: <20060201124950.GA2137@elf.ucw.cz>
References: <200602010141.53974.rjw@sisk.pl> <20060201114717.GA1768@elf.ucw.cz>
	<200602012225.01695.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============027128243090383197=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200602012225.01695.nigel@suspend2.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============027128243090383197==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > This is an experimantal patch aimed at the "unable to freeze processes
> > > under load" problem.
> > >
> > > On my box the 2.6.16-rc1-mm4 kernel with this patch applied survives the
> > > "dd if=/dev/hda of=/dev/null" test.
> > >
> > > Please have a look.
> >
> > It makes it better (well, I used my own, simpler variant, but that
> > should not matter; patch is attached). I now can't reproduce hangs
> > with simple stress testing, but running kernel make alongside that
> > makes it hang sometimes. Example of non-frozen gcc:
> >
> > gcc           D EEE06A70     0  1750   1749  1751
> > (NOTLB)
> > df85df38 00000046 bf878130 eee06a70 00004111 eee06a70 eee06a70
> > 003d0900
> >        00000000 c0137cf5 df85c000 00000000 c058ada2 c012503e ef2c915c
> > ef2c9030
> >        c1c0b480 7c3b8500 003d0927 df85c000 00000a98 7c3b8500 003d0927
> > c0770800
> > Call Trace:
> >  [<c0137cf5>] attach_pid+0x25/0xb0
> >  [<c058ada2>] _write_unlock_irq+0x12/0x30
> >  [<c012503e>] copy_process+0xe5e/0x11b0
> >  [<c0588f74>] wait_for_completion+0x94/0xd0
> >  [<c0121690>] default_wake_function+0x0/0x10
> >  [<c01254d9>] do_fork+0x149/0x210
> >  [<c0101218>] sys_vfork+0x28/0x30
> >  [<c0103231>] syscall_call+0x7/0xb
> >
> > ...maybe solving this would solve journalling problems, too? It is
> > similar AFAICT.
> 
> What exactly is the journalling problem?

Hangs by freezing everything at same time only happen with journalling
filesystems; there kjournald needs to be running if we want user
threads to be stoppable.

> > @@ -87,7 +87,6 @@ static int prepare_processes(void)
> >  	int error;
> >
> >  	pm_prepare_console();
> > -	sys_sync();
> >  	disable_nonboot_cpus();
> >
> >  	if (freeze_processes()) {
> 
> That will help speed up freezing, but it won't help the integrity of your data 
> if you don't resume.

See the patch better; it is now done between freezing userspace and
kernel threads.

> >  /*
> >   * Timeout for stopping processes
> >   */
> > -#define TIMEOUT	(6 * HZ)
> > +#define TIMEOUT	(60 * HZ)
> 
> You're kidding, right?

sync takes long time... and 6 seconds were not enough to deliver
signals on highly-loaded ext2.
							Pavel

-- 
Thanks, Sharp!

--===============027128243090383197==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============027128243090383197==--
