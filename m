From: "Vitaly Wool" <vitalywool@gmail.com>
Subject: Re: + rework-pm_ops-pm_disk_mode-kill-misuse.patch added
	to -mm tree
Date: Thu, 22 Mar 2007 16:41:40 +0300
Message-ID: <acd2a5930703220641p6bd02f5dk433232093a331772@mail.gmail.com>
References: <200703212334.l2LNYDjj007030@shell0.pdx.osdl.net>
	<20070322094825.GA29627@flint.arm.linux.org.uk>
	<20070322015614.dafa1ed7.akpm@linux-foundation.org>
	<20070322100355.GA6834@elf.ucw.cz>
	<1174558128.3944.78.camel@johannes.berg>
	<20070322132622.GD29627@flint.arm.linux.org.uk>
	<20070322133117.GC6050@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070322133117.GC6050@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>, Russell King <rmk@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

On 3/22/07, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> > > No, once SOFTWARE_SUSPEND is configured there's *no way* to disable it
> > > after the fact via pm_ops. Read valid_state() in kernel/power/main.c.
> >
> > So how does a platform with only flash (and an insufficient amount of
> > flash at that) tell the suspend code that suspend-to-disk is not
> > supported?
>
> Hohum, perhaps it can suspend to SD card? Or perhaps it can suspend
> over network?

Cool, imagine your MP3 player suspending over network... Or suspending
to SD card and switching off in the middle of the process leaving the
SD card filesystem broken. Congratulations, you've bought a nice
device...

Vitaly
