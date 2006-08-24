From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : [HELP] Power management for embedded system
Date: Thu, 24 Aug 2006 09:37:39 +0000 (GMT)
Message-ID: <20060824093739.5085.qmail@web25802.mail.ukl.yahoo.com>
References: <20060824090455.GA18202@flint.arm.linux.org.uk>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060824090455.GA18202@flint.arm.linux.org.uk>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

Russell King wrote:
> On Thu, Aug 24, 2006 at 08:44:25AM +0000, moreau francis wrote:
>> Mips one seems to be a copy and paste of arm one and both of them
>> have removed all APM bios stuff orginally part of i386 implementation.
> =

> The BIOS stuff makes no sense on ARM - there isn't a BIOS to do anything
> with.

I haven't said that it has been widely/wrongly removed...

> =

>> It doesn't seem that APM is something really stable and finished.
> =

> It's complete.  It's purpose is to provide the interface to userland so
> that programs know about suspend/resume events, and can initiate suspends.
> Eg, the X server.
> =


Is there something specific to ARM in this implementation ? I don't think
so and it's surely the reason why MIPS did copy it with almost no changes.
I understand that ARM implementation has been the first one but maybe now
why not making it the common power management for embedded system that
could be used by all arches which need it ?

BTW, why has apm_cpu_idle() logic been removed from ARM implementation ?

> The power management really comes from the Linux drivers themselves,
> which are written to peripherals off when they're not in use.  The other
> power saving comes from things like cpufreq - again, nothing to do with
> the magical "APM" or "ACPI" terms.

BTW why is it still called "APM" on ARM ?

thanks

Francis
