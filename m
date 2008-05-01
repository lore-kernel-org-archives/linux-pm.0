From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Some sort corruption of my Thermal Subsystem after
	suspend to	ram
Date: Thu, 1 May 2008 18:09:46 +0200
Message-ID: <20080501160946.GA26089__40859.0373852805$1209658276$gmane$org@elf.ucw.cz>
References: <4818D9AB.3040402@googlemail.com>
	<200805010157.58607.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200805010157.58607.lenb@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Gabriel C <nix.or.die@googlemail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> The ICH9 apparently provides a pair of memory mapped on-die thermal sensors.
> 
> The sensors basically shut off your hardware if it gets too hot.

Are the sensors driven by ACPI? Probably yes, otherwise they would be
unable to shut down the system.

> ICH9 exports the base address for the sensors via a PCI device -- D31:F6, aka Linux 00:1f.6
> 
> I'm not aware of a native Linux device driver that talks to this device
> (nor can I think of a useful purpose for such a driver)
> So it seems what is in play here is any BIOS code that talks to this device,
> and Linux's standard PCI config space restore.
> 
> My guess is that the BIOS is enabling the device on cold boot,
> but not enabling it after resume from S3.

That sounds like a BIOS problem, right? If the piece of hardware is
driven by BIOS, Linux can't be responsible for saving/restoring it.
 									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
