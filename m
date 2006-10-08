From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Funky "Blue screen" issue while rebooting from X with 2.6.18-git21
Date: Sun, 8 Oct 2006 18:34:06 +0000
Message-ID: <20061008183406.GA4496@ucw.cz>
References: <9a8748490610041316w3ad442a6rf8f5fc5189fd72ac@mail.gmail.com> <20061008174759.GF6755@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750903AbWJHSeT@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20061008174759.GF6755@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

On Sun 08-10-06 19:47:59, Adrian Bunk wrote:
> On Wed, Oct 04, 2006 at 10:16:41PM +0200, Jesper Juhl wrote:
> > I have a strange "problem" with 2.6.18-git21 that I've never had with
> > any previous kernel. If I open up an xterm in X, su to root and
> > 'reboot' (or 'shutdown -r now') I instantly get a blue screen that
> > persists until the box actually reboots.
> 
> Pavel, is this a known issue or should Jesper bisect?

Jesper should show it is kernel problem and not userland race.

If userspace does kill -15 -1; kill -9 -1, and X fails to shut down in
time, it is userland problem ('should wait for X to shut down').

-- 
Thanks for all the (sleeping) penguins.
