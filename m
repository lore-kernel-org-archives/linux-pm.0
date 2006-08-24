From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [HELP] Power management for embedded system
Date: Thu, 24 Aug 2006 10:04:55 +0100
Message-ID: <20060824090455.GA18202@flint.arm.linux.org.uk>
References: <20060824084425.83538.qmail@web25802.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060824084425.83538.qmail@web25802.mail.ukl.yahoo.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 24, 2006 at 08:44:25AM +0000, moreau francis wrote:
> Mips one seems to be a copy and paste of arm one and both of them
> have removed all APM bios stuff orginally part of i386 implementation.

The BIOS stuff makes no sense on ARM - there isn't a BIOS to do anything
with.

> It doesn't seem that APM is something really stable and finished.

It's complete.  It's purpose is to provide the interface to userland so
that programs know about suspend/resume events, and can initiate suspends.
Eg, the X server.

The power management really comes from the Linux drivers themselves,
which are written to peripherals off when they're not in use.  The other
power saving comes from things like cpufreq - again, nothing to do with
the magical "APM" or "ACPI" terms.

On embedded platforms, you shouldn't think about power management in
terms of the non-embedded PM technologies.

-- =

Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
