From: Olivier Galibert <galibert@pobox.com>
Subject: Re: [linux-pm] [RFC] userland swsusp
Date: Thu, 17 Nov 2005 18:31:17 +0100
Message-ID: <20051117173117.GC10402@dspnet.fr.eu.org>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com> <20051116191051.GG2193@spitz.ucw.cz> <20051117165437.GA10402@dspnet.fr.eu.org> <20051117164451.GA27178@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932437AbVKQRb2@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20051117164451.GA27178@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 17, 2005 at 08:44:51AM -0800, Greg KH wrote:
> Both.  -to-ram depends on your video chip,

i855GM with xorg-6.8.2 (-r6 gentoo) ?

i830CGC with xorg-6.8.2 (-r4 gentoo) ?


> but to-disk should work just fine.

Ok.

> If not, please report bugs.

I shall.

Is the acpi problem with PWRF used over PWRC and PWRF not sending
events (hence no wakeup) solved?

  OG.
