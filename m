From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] OOPS: divide error while s2dsk (2.6.20-rc1-mm1)
Date: Tue, 19 Dec 2006 01:52:27 +0100
Message-ID: <200612190152.28457.rjw@sisk.pl>
References: <4586797B.3080007@gmail.com> <200612182338.24843.rjw@sisk.pl> <20061218151710.32ceba0d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932559AbWLSAu3@vger.kernel.org>
In-Reply-To: <20061218151710.32ceba0d.akpm@osdl.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-pm@lists.osdl.org, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, 19 December 2006 00:17, Andrew Morton wrote:
> On Mon, 18 Dec 2006 23:38:23 +0100
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > > > Looks like we have a problem with slab shrinking here.
> > > > 
> > > > Could you please use gdb to check what exactly is at shrink_slab+0x9e?
> > > 
> > > Sure, but not till Friday, sorry (I am away).
> > 
> > I reproduced this on one box, but then it turned out that EIP was at line 195
> > of mm/vmscan.c where there was
> > 
> > do_div(delta, lru_pages + 1);
> 
> That implies that we passed it lru_pages=-1.
> 
> Presumably the logic in
> vmscanc-account-for-memory-already-freed-in-seeking-to.patch caused that.
> 
> > Well, I have no idea how this can lead to a divide error (lru_pages is
> > unsigned).
> > 
> > I'm unable to reproduce this on another i386 box, so it seems to be somewhat
> > configuration specific.
> > 
> 
> There is one wart in shrink_all_memory() and I think we should fix that in
> 2.6.20.
> 
> Please check the below.

Fine by me.

> I'll drop vmscanc-account-for-memory-already-freed-in-seeking-to.patch.  It
> has other stuff in it which we might still need.  But altering
> sc->swap_cluster_max in that manner looks odd.

Agreed.

Greetings,
Rafael
