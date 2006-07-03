From: Andrew Morton <akpm@osdl.org>
Subject: Re: swsusp regression
Date: Mon, 3 Jul 2006 16:10:34 -0700
Message-ID: <20060703161034.a5c4fba9.akpm@osdl.org>
References: <44A99DFB.50106@gmail.com>
	<44A99FE5.6020806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751005AbWGCXKn@vger.kernel.org>
In-Reply-To: <44A99FE5.6020806@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: jirislaby@gmail.com, linux-kernel@vger.kernel.org, pavel@suse.cz, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

On Tue, 04 Jul 2006 00:53:02 +0159
Jiri Slaby <jirislaby@gmail.com> wrote:

> Jiri Slaby napsal(a):
> > Hello,
> > 
> > when suspending machine with hyperthreading, only Freezing cpus appears and then
> 
> Note: suspending to disk; done by:
> echo reboot > /sys/power/disk
> echo disk > /sys/power/state
> 
> > it loops somewhere. I tried to catch some more info by pressing sysrq-p. Here
> > are some captures:
> > http://www.fi.muni.cz/~xslaby/sklad/03072006074.gif
> > http://www.fi.muni.cz/~xslaby/sklad/03072006075.gif
> 
> One more from some previous kernels (cutted sysrq-t):
> http://www.fi.muni.cz/~xslaby/sklad/22062006046.jpg
> 

If you replace kernel/stop_machine.c with the version from 2.6.17, does it
help?
