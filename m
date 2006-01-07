From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch] pm: fix runtime powermanagement's /sys
	interface
Date: Fri, 6 Jan 2006 22:19:03 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0601062208510.22627-100000@netrider.rowland.org>
References: <20060107000826.GC20399@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============78992681077032501=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060107000826.GC20399@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============78992681077032501==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Sat, 7 Jan 2006, Pavel Machek wrote:

> > This trend is extremely alarming!!
> 
> It scares me a bit, too. 

> I think we should start with string-based interface, with just two
> states ("on" and "off"). That is easily extensible into future, and
> suits current PCMCIA nicely. It also allows us to experiment with PCI
> power management... I can cook up a patch, but it will be simple
> reintroduction of .../power file under different name.

That sounds good to me, provided you add to dev_pm_info a pointer to an
array of string pointers, the names of the available states.  For now all
devices can share a single array with just two entries ("on" and "off",
or even "0" and "2").  In the future, bus drivers will be able to
substitute a pointer to a private array with device-specific state names.

Of course, this change will require you to add something like

	const char *name;

to the pm_message_t struct.  PM-aware drivers will be able to use it to
see which state was requested, and other drivers can ignore it.

In fact, for PM-aware drivers the name field makes the event field 
unnecessary.  But until all drivers are PM-aware we can't get rid of it.

Alan Stern


--===============78992681077032501==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============78992681077032501==--
