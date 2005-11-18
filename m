From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [RFC] userland swsusp
Date: Fri, 18 Nov 2005 23:22:07 +0000
Message-ID: <20051118232206.GB2359@spitz.ucw.cz>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com> <20051116191051.GG2193@spitz.ucw.cz> <20051117165437.GA10402@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751192AbVKRXjh@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20051117165437.GA10402@dspnet.fr.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Olivier Galibert <galibert@pobox.com>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > What unstable implementation? swsusp had very little regressions over past
> > year or so. Drivers were different story, but nothing changes w.r.t. drivers.
> 
> Do you mean swsusp is actually supposed to work?  Suspend-to-ram,
> suspend-to-disk or both?

Read the docs. swsusp is suspend-to-disk, of course.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         
