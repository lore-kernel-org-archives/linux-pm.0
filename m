From: "Ray Lee" <ray-lk@madrabbit.org>
Subject: Re: ACPI_WMI: worst config description of all times
Date: Thu, 7 Feb 2008 15:33:54 -0800
Message-ID: <2c0942db0802071533l5c3b98fel90946b73f8a9586b@mail.gmail.com>
References: <20080207214715.GA15211@elf.ucw.cz>
	 <200802071727.38743.lenb@kernel.org>
	 <20080207223455.GB6096@elf.ucw.cz>
	 <200802072318.28313.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200802072318.28313.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Feb 7, 2008 3:18 PM, Carlos Corbacho <carlos@strangeworlds.co.uk> wrote:
> As for the Kconfig - I'm open to suggestions.

While the kconfig text is supposed to say 'what' something is, the
more valuable piece of information it provides is *why* one would want
to enable it.

Do you have list of hardware/platforms that require this feature to
get the hardware to work? (acer abc123, tcm1100 xyz) If so, providing
that information to the user/distributions is the right first step.
Tell them why they want this feature.

Better, if there are kernel drivers that require this (and currently
only those drivers), then have those kernel drivers enable ACPI WMI,
and otherwise leave it off. If/when the userspace accessible bits go
in, it can be exposed to the configurator then.

Ray
