From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] 2.6.21-rc1: known regressions (v2) (part 1)
Date: Fri, 2 Mar 2007 13:26:41 +0100
Message-ID: <20070302122641.GA3034@elf.ucw.cz>
References: <Pine.LNX.4.64.0702202043280.4043@woody.linux-foundation.org> <20070226220152.GA29575@stusta.de> <20070228211318.GB4301@mellanox.co.il> <b6a2187b0702281945n5f62a6b5w1c535de3ef9aaa8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b6a2187b0702281945n5f62a6b5w1c535de3ef9aaa8f@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Adrian Bunk <bunk@stusta.de>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu 2007-03-01 11:45:35, Jeff Chua wrote:
> On 3/1/07, Michael S. Tsirkin <mst@mellanox.co.il> wrote:
> 
> > with 2.6.20, pressing Fn/F4 generates an ACPI event and triggers suspend to RAM.
> >
> > On 2.6.21-rc2, after resume (when the box is accessible from network),
> > pressing Fn/F4 again does not seem to have any effect.
> 
> I have the same problem on my IBM X60s on rc1 and rc2. Can't resume
> from RAM, can't suspend to disk. It is possible to revert all the
> changes to ACPI and test it?

As I said elsewhere in the thread, suspend/resume to RAM works ok on
my thinkpad x60. I posted my .config there, perhaps difference is in
it? Ingo identified KVM as possible culprit.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
