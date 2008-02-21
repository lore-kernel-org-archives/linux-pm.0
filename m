From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] power_state: get rid of write-only variable in SATA
Date: Thu, 21 Feb 2008 11:33:50 -0800
Message-ID: <20080221193350.DA772235007@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <20080221125652.GA23548@elf.ucw.cz>
 <47BDA22F.5060300@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757890AbYBUTeG@vger.kernel.org>
In-Reply-To: <47BDA22F.5060300@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: pavel@ucw.cz, jgarzik@pobox.com
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> libata uses it under the assumption that "other parts" of the system are 
> aware of this variable.
>
> May I assume that the API has changed such that this is no longer necessary?

Yes.  The original motivation for dev->power.power_state was to let
the writes to /sys/devices/.../power/state support a PCI-specific
policy for device power state transition.  And the motivation for
any driver (or framework) to modify that was that the PM core didn't
update it in all the relevant code paths (it wan't clear how to do
that either), which mean those sysfs files could make trouble.

That file is gone; everything supporting its usage can now go away.
(And the PCI-specific policy -- "only transitions to/from D0 are
allowed" -- can be managed by PCI drivers, and ignored by others
on more flexible hardware.)

The minor problem removing it is that there's some code which has
used fields in power_state for some driver state.  But if all that
usage is write-only in the drivers (is that true now for SATA?),
then it's safe to remove the /sys/devices/.../power/state support
from framework code and elsewhere.

- Dave
