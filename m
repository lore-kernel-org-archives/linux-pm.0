From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Suspend "core": what to do now ?
Date: Tue, 28 Jun 2005 14:44:15 +0200
Message-ID: <20050628124414.GA11129@atrey.karlin.mff.cuni.cz>
References: <1119851395.5133.112.camel@gaston>
	<1119912918.30369.7.camel@localhost.localdomain>
	<1119916159.5133.145.camel@gaston>
	<1119931577.5133.189.camel@gaston>
	<20050628045846.GA10735@atrey.karlin.mff.cuni.cz>
	<1119934956.5133.192.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============89834760098041766=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1119934956.5133.192.camel@gaston>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Adam Belay <abelay@novell.com>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============89834760098041766==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > However, PM_DISK_PLATFORM and PM_DISK_FIRMWARE sort-of abuse the pm_ops
> > > that I have killed to call into arch code... it's all crap as it exposes
> > > to all archs some behaviours that may not be supported by those archs.
> > 
> > Feel free to kill PM_DISK_FIRMWARE. PM_DISK_PLATFORM looks like the
> > "right way" to do swsusp on acpi-enabled systems, so it should stay...
> 
> No, not in this form. It will be under arch control too. Makes no

No problem. What I was trying to say is "feel free to remove
functionality of PM_DISK_FIRMWARE". Functionality of PM_DISK_PLATFORM
needs to stay.

> What I'll do is that I'll keep the "shutdown" case and will rename the
> file generic_disk.c. It will be a "drop in" implementation that
> architectures can use if they have no callbacks need at all. PPC won't
> use it though. And I suspect x86 neither.

Sounds good to me.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.

--===============89834760098041766==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============89834760098041766==--
