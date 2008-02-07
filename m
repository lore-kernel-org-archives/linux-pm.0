From: Len Brown <lenb@kernel.org>
Subject: Re: ACPI_WMI: worst config description of all times
Date: Thu, 7 Feb 2008 17:27:38 -0500
Message-ID: <200802071727.38743.lenb@kernel.org>
References: <20080207214715.GA15211@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20080207214715.GA15211@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday 07 February 2008 16:47, Pavel Machek wrote:
> 
> See? It even has completely useless help text.
> 
> Does WMI stand for Windows Management Instrumentation? It is some
> server management feature? What is it good for?

Thank you for the feedback, Pavel.

There is an additional patch which creates
Documentation/acpi/wmi.txt, but I witheld it from
this batch because it needs to be revised.
If you are not subscribed to the linux-acpi list
you can find it here:

http://marc.info/?l=linux-acpi&m=120217838010224&w=2

Clearly we neeed to update the Kconfig doc as well when
we revise and push that patch.

-Len

ps. the answers to your questions are "yes" and "see NOTE" below.

>   WMI (EXPERIMENTAL) (ACPI_WMI) [N/m/y/?] (NEW) ?
> 
> This driver adds support for the ACPI-WMI mapper device (PNP0C14)
> found on some systems.
> 
> NOTE: You will need another driver or userspace application on top of
> this to actually use anything defined in the ACPI-WMI mapper.
> 
> 
