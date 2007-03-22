From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [RFC] dynamic device power management proposal
Date: Thu, 22 Mar 2007 14:44:51 +0100
Message-ID: <200703221444.52065.oneukum@suse.de>
References: <Pine.LNX.4.44L0.0703191135360.14222-100000@iolanthe.rowland.org>
	<200703220042.20471.lenb@kernel.org>
	<20070322132052.GA7221@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070322132052.GA7221@elf.ucw.cz>
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
To: linux-pm@lists.linux-foundation.org
Cc: linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Am Donnerstag, 22. M=E4rz 2007 14:20 schrieb Pavel Machek:
> > > That's not how the USB implementation works. =A0Although a timestamp =
like =

> > > the one you describe is going to be added.
> > =

> > I sort of like this idea -- it seems that it is low overhead.
> > Of course it requires every device driver to be changed.
> > Instead we could maybe hook the generic driver entry points
> > and do this in the framework -- dunno if that is viable.
> =

> No, you can't get around changing all the drivers.
> =

> Generic entry points are for _system_ suspend, and if you try to abuse
> them for runtime PM, you'll have to audit/change all the drivers.

Is this your position regarding USB autosuspend, too? Should we use
other methods than suspend/resume?

	Regards
		Oliver

PS: Do we have _two_ pm lists?
