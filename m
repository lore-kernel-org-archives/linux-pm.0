From: Paul Mackerras <paulus@samba.org>
Subject: Re: [linux-pm] Building ACPI for PPC architecture
Date: Tue, 24 Oct 2006 09:02:55 +1000
Message-ID: <17725.18975.597949.373572@cargo.ozlabs.ibm.com>
References: <200610230655.MAA16239@WS0005.indiatimes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200610230655.MAA16239@WS0005.indiatimes.com>
Sender: linux-acpi-owner@vger.kernel.org
To: rajeshprabhu72721 <rajeshprabhu72721@indiatimes.com>
Cc: linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

rajeshprabhu72721 writes:

> We are trying to build ACPI for PPC e300 core . The problem is we

Why?  What problem do you think that will solve?

> donot have a BIOS running to supply the System Descriptor Tables to
> ACPI during boot. So ACPI gets disabled during boot. Are the system
> desc tables must for the ACPI to run? Or is there a method where we
> can avoid these tables and make ACPI work directly. Without BIOS how
> do we make ACPI up and running?

ACPI is a bad idea (see Linus Torvalds' rants about ACPI in the
linux-kernel mailing list archives for the reasons).  Fortunately no
PowerPC platform has tried to implement it.  If nothing else, the
endianness difference would make it impracticable.

Paul.
