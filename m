From: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.21-rc1: known regressions (v2) (part 1)
Date: Mon, 5 Mar 2007 01:04:21 +0100
Message-ID: <20070305000421.GF3441@stusta.de>
References: <Pine.LNX.4.64.0702202043280.4043@woody.linux-foundation.org> <20070226220152.GA29575@stusta.de> <20070228211318.GB4301@mellanox.co.il> <b6a2187b0702281945n5f62a6b5w1c535de3ef9aaa8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b6a2187b0702281945n5f62a6b5w1c535de3ef9aaa8f@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, lenb@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 01, 2007 at 11:45:35AM +0800, Jeff Chua wrote:
> On 3/1/07, Michael S. Tsirkin <mst@mellanox.co.il> wrote:
> 
> >with 2.6.20, pressing Fn/F4 generates an ACPI event and triggers suspend 
> >to RAM.
> >
> >On 2.6.21-rc2, after resume (when the box is accessible from network),
> >pressing Fn/F4 again does not seem to have any effect.
> 
> I have the same problem on my IBM X60s on rc1 and rc2. Can't resume
> from RAM, can't suspend to disk. It is possible to revert all the
> changes to ACPI and test it?

This is with CONFIG_KVM=n?

> Jeff.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

