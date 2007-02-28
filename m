From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.21-rc1: known regressions (v2) (part 1)
Date: Wed, 28 Feb 2007 22:27:06 +0100
Message-ID: <1172698026.11473.40.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0702202043280.4043@woody.linux-foundation.org>
	 <20070226220152.GA29575@stusta.de>  <20070228211318.GB4301@mellanox.co.il>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070228211318.GB4301@mellanox.co.il>
Sender: linux-acpi-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Adrian Bunk <bunk@stusta.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, lenb@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2007-02-28 at 23:13 +0200, Michael S. Tsirkin wrote:
> >Subject    : ThinkPad T60: no screen after suspend to RAM
> >References : http://lkml.org/lkml/2007/2/22/391
> >Submitter  : Michael S. Tsirkin <mst@mellanox.co.il>
> >Handled-By : Ingo Molnar <mingo@elte.hu>
> >Status     : unknown
> 
> Just reproduced this in -rc2.
> Another thing I noticed:
> with 2.6.20, pressing Fn/F4 generates an ACPI event and triggers suspend to RAM.
> 
> On 2.6.21-rc2, after resume (when the box is accessible from network),
> pressing Fn/F4 again does not seem to have any effect.

Can you please get the dmesg output after resume via the network ?

	tglx


