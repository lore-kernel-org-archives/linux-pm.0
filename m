From: "Javi Merino" <javi.merino@arm.com>
Subject: Re: [PATCH] tools/thermal: tmon: fix compilation errors when
 building statically
Date: Tue, 10 Jun 2014 16:16:49 +0100
Message-ID: <20140610151649.GB2798@e104805>
References: <1401728897-25188-1-git-send-email-javi.merino@arm.com>
 <20140602045457.6b519e43@jacob-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140602045457.6b519e43@jacob-desktop>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rui,

On Mon, Jun 02, 2014 at 12:54:57PM +0100, Jacob Pan wrote:
> On Mon,  2 Jun 2014 18:08:17 +0100
> "Javi Merino" <javi.merino@arm.com> wrote:
> 
> > tmon fails to build statically with the following error:
> > 
> > $ make LDFLAGS=-static
> > gcc -O1 -Wall -Wshadow -W -Wformat -Wimplicit-function-declaration
> > -Wimplicit-int -fstack-protector -D VERSION=\"1.0\" -static tmon.o
> > tui.o sysfs.o pid.o   -o tmon -lm -lpanel -lncursesw  -lpthread
> > tmon.o: In function `tmon_sig_handler': tmon.c:(.text+0x21):
> > undefined reference to `stdscr' tmon.o: In function `tmon_cleanup':
> > tmon.c:(.text+0xb9): undefined reference to `stdscr'
> > tmon.c:(.text+0x11e): undefined reference to `stdscr'
> > tmon.c:(.text+0x123): undefined reference to `keypad'
> > tmon.c:(.text+0x12d): undefined reference to `nocbreak' tmon.o: In
> > function `main': tmon.c:(.text+0x785): undefined reference to `stdscr'
> > tmon.c:(.text+0x78a): undefined reference to `nodelay'
> > tui.o: In function `setup_windows':
> > tui.c:(.text+0x131): undefined reference to `stdscr'
> > tui.c:(.text+0x176): undefined reference to `stdscr'
> > tui.c:(.text+0x19f): undefined reference to `stdscr'
> > tui.c:(.text+0x1cc): undefined reference to `stdscr'
> > tui.c:(.text+0x1ff): undefined reference to `stdscr'
> > tui.o:tui.c:(.text+0x229): more undefined references to `stdscr'
> > follow tui.o: In function `show_cooling_device':
> > [...]
> > 
> > stdscr() and friends are in libtinfo (part of ncurses) so add it to
> > the libraries that are linked in when compiling tmon to fix it.
> > 
> Acked-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Thanks!

Rui, can you pick this up?

Cheers,
Javi
