From: Greg KH <greg@kroah.com>
Subject: Re: [linux-pm] [RFC] userland swsusp
Date: Thu, 17 Nov 2005 13:56:13 -0800
Message-ID: <20051117215612.GA8797@kroah.com>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com> <20051116191051.GG2193@spitz.ucw.cz> <20051117165437.GA10402@dspnet.fr.eu.org> <20051117164451.GA27178@kroah.com> <20051117201509.GA25250@finwe.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965140AbVKQXzW@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20051117201509.GA25250@finwe.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 17, 2005 at 09:15:09PM +0100, Jacek Kawa wrote:
> Greg KH wrote:
> 
> > > > What unstable implementation? swsusp had very little regressions over past
> > > > year or so. Drivers were different story, but nothing changes w.r.t. drivers.
> > > Do you mean swsusp is actually supposed to work?  Suspend-to-ram,
> > > suspend-to-disk or both?
> > Both.  -to-ram depends on your video chip, but to-disk should work just
> > fine.  If not, please report bugs.
> 
> Thanks, I've just realized, that I probably forgot to CC anyone last time... 
> :)
> 
> So, may I kindly ask to look on:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0511.1/1863.html ?

Care to file this in bugzilla.kernel.org and assign it to Pavel?

thanks,

greg k-h
