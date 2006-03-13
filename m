From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: Re: standby to disk transition
Date: Mon, 13 Mar 2006 03:48:11 -0500
Message-ID: <20060313084811.GC20569@neo.rr.com>
References: <E1FIctI-0000jE-00@porton.narod.ru>
	<20060313083037.GA3495@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============35061104420010825=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060313083037.GA3495@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <ncunningham@linuxmail.org>
Cc: linux-pm@osdl.org, "Victor Porton,,," <porton@ex-code.com>
List-Id: linux-pm@vger.kernel.org

--===============35061104420010825==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 13, 2006 at 09:30:38AM +0100, Pavel Machek wrote:
> On Po 13-03-06 07:34:36, Victor Porton,,, wrote:
> > There should be something such which would cause (after user
> > specified timeout, e.g. a hour) automatically switch the
> > system from standby to suspend to disk (or suspend to mem).
> ....
> > Or as a possible alternative, we could suspend SIMULTANEOUSLY
> > to disk and to mem (with switching into suspend-to-disk by
> > timeout), to have both quick restoration and automatically
> > fully turning it off.
> 
> Yep, it would be nice.
> 
> Does that mean you are working on it and will send me a patch? Do you
> want help coding?
> 							Pavel

The simultaneous idea sounds very similar to the idea Nigel had around a year
ago.  It may have been implemented to some degree.

The timeout feature could be done using the ACPI alarm interface, but there's
no reliable way of knowing how long the system can remain in a suspend state
on the x86 mobile platform, so waking up at the right time would be tricky if
not impossible.

Thanks,
Adam

--===============35061104420010825==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============35061104420010825==--
