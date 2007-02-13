From: Pavel Machek <pavel@suse.cz>
Subject: Re: Request for testing remote wakeup during STD
Date: Tue, 13 Feb 2007 12:35:47 +0100
Message-ID: <20070213113547.GI12996@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0702092244570.32161-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0702092244570.32161-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> There have been reports of problems related to shutting down with remote =

> wakeup enabled on EHCI USB controllers in 2.6.20; see
> =

> 	http://bugzilla.kernel.org/show_bug.cgi?id=3D7828
> =

> In brief, some people have found that if ehci-hcd is loaded and the =

> controller is suspended when they try to shut down their systems, the =

> machine reboots immediately instead of turning off.  Apparently this is =

> caused by the firmware mistakenly thinking that a remote-wakeup event has =

> occurred.  Admittedly, remote wakeup from a system sleep is still black =

> magic to most of us...
> =

> I wrote a patch to try and fix the problem by turning off EHCI remote
> wakeup from within the driver's shutdown() method.  The patch is here:
> =

> 	http://bugzilla.kernel.org/attachment.cgi?id=3D10313&action=3Dview
> =

> However I'm concerned that this might affect suspend-to-disk.  Some lucky =

> people have systems which do keep their EHCI controllers in D3hot during =

> STD, and such people might reasonably want Wake-on-USB to work properly.  =

> It seems likely that the patch would prevent it from working.

I do not think such "lucky people" exist. And not being able to
control the wakeups.... no I do not think that feature is useful,
yet. KISS.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
