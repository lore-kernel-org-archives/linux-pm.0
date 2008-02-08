From: "Ray Lee" <ray-lk@madrabbit.org>
Subject: Re: ACPI_WMI: worst config description of all times
Date: Thu, 7 Feb 2008 16:12:24 -0800
Message-ID: <2c0942db0802071612r1b32f996jc26ac3792b8c31fc@mail.gmail.com>
References: <20080207214715.GA15211@elf.ucw.cz>
	 <200802072318.28313.carlos@strangeworlds.co.uk>
	 <2c0942db0802071533l5c3b98fel90946b73f8a9586b@mail.gmail.com>
	 <200802072351.32521.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200802072351.32521.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Feb 7, 2008 3:51 PM, Carlos Corbacho <carlos@strangeworlds.co.uk> wrote:
> On Thursday 07 February 2008 23:33:54 Ray Lee wrote:
> > Do you have list of hardware/platforms that require this feature to
> > get the hardware to work? (acer abc123, tcm1100 xyz)
>
> I have a very long list of Acer laptops that are supported - which is far too
> long, and changes on far too much of a regular basis to put in there.
>
> Perhaps adding something like "This driver is also a required dependency to
> build the firmware specific drivers needed for many laptops, including Acer
> and HP machines"?

<nod>

> (There's currently another ACPI-WMI based driver in development related to
> more HP laptops, and acer-wmi also supports a handful of non-Acer laptops).
>
> I don't think explaining what WMI is, and how ACPI-WMI is related to it is
> that useful in Kconfig here; so I agree that further elaborating on the 'why'
> this should be enabled is definitely worth doing.
>
> > Better, if there are kernel drivers that require this (and currently
> > only those drivers), then have those kernel drivers enable ACPI WMI,
>
> Wouldn't that require 'select' though, and I'm led to believe that's seriously
> frowned upon these days?

Depends who you talk to. It's certainly the fodder for a yearly flamewar.

While I'm not trying to set you up for a firing squad, if you can show
that the only use this driver has is as underlying support for Acer/HP
xyz drivers, and that those drivers require this one, then that
situation really is what select is in there for. Anyone who argues
against using select in that case is really just arguing against the
mere existence of the kconfig select keyword itself.
