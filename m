From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [PATCH 3/5] [pm] Respect the actual device power
	states in sysfs interface
Date: Sun, 19 Feb 2006 16:17:01 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0602191611130.8676-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0602171758160.30811-100000@monsoon.he.net>
	<20060218155543.GE5658@openzaurus.ucw.cz>
	<Pine.LNX.4.50.0602191557520.8676-100000@monsoon.he.net>
	<20060220000907.GE15608@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============89764562825252336=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060220000907.GE15608@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

--===============89764562825252336==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Mon, 20 Feb 2006, Pavel Machek wrote:

> On Ne 19-02-06 15:59:25, Patrick Mochel wrote:
> >
> > On Sat, 18 Feb 2006, Pavel Machek wrote:
> >
> > > Hi!
> > >
> > > > Fix the per-device state file to respect the actual state that
> > > > is reported by the device, or written to the file.
> > >
> > > Can we let "state" file die? You actually suggested that at one point.
> > >
> > > I do not think passing states in u32 is good idea. New interface that passes
> > > state as string would probably be better.
> >
> > Yup, in the future that will be better. For now, let's work with what we
> > got and fix 2.6.16 to be compatible with previous versions..
>
> It already is. It accepts "0" and "2" and "3". That's all values that
> used to work.

The core should not dictate the valid range of values. The bus drivers
should decide, since they are their states. "1" also used to work.

> Other values used to trigger BUG() in pci.c (and we do not want to
> re-introduce _that_ behaviour, right?).

I don't follow - the BUG() call was introduced recently for reasons
unknown. The interface had never triggered that previously.

> If you add u32 into pm_message_t, it will be impossible to remove in
> future.

I don't follow this argument either.

I really fail to see what your fundamental objection is. This restores
compatability, makes the core simpler, and adds the ability to use the
additional states, should drivers choose to implement them; all for
relatively little code. It seems a like a good thing to me..

Thanks,


	Pat


--===============89764562825252336==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============89764562825252336==--
