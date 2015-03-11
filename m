From: Thomas Renninger <trenn@suse.de>
Subject: Re: Bad rpath in cpupower with 4.0-rcX
Date: Wed, 11 Mar 2015 12:53:57 +0100
Message-ID: <3001692.z661NIszxI@skinner>
References: <20150306134745.GC4801@hansolo.redhat.com> <CA+5PVA6Jo9LTbhduCs0eYXJxmdG-39PR-fOKmABNLO2F3btXUA@mail.gmail.com> <15697793.jrEQ5UURAe@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50299 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770AbbCKLyA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 11 Mar 2015 07:54:00 -0400
In-Reply-To: <15697793.jrEQ5UURAe@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Josh Boyer <jwboyer@fedoraproject.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "sriram@marirs.net.in" <sriram@marirs.net.in>, Linux PM list <linux-pm@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>

On Tuesday, March 10, 2015 11:30:44 PM Rafael J. Wysocki wrote:
> On Tuesday, March 10, 2015 08:33:54 AM Josh Boyer wrote:
> > On Fri, Mar 6, 2015 at 8:47 AM, Josh Boyer <jwboyer@fedoraproject.org> 
wrote:
> > > Hi All,
> > > 
> > > Commit 5c1de006e8e66 (cpupower Makefile change to help run the tool
> > > without 'make install') added an rpath to the cpupower binary.  From
> > > what I can understand, this is to make it easier to run cpupower from
> > > the local build directory without having to run make install.  It does
> > > accomplish that, but it also leaves the binary with the rpath in it
> > > which is considered bad practice.  It also causes cpupower to fail in
> > > rpmbuild with the following error:
> > > 
> > > ERROR   0004: file '/usr/bin/cpupower' contains an insecure rpath './'
> > > in [./]
> > > error: Bad exit status from /var/tmp/rpm-tmp.A6u26r (%install)
> > > 
> > >     Bad exit status from /var/tmp/rpm-tmp.A6u26r (%install)
> > > 
> > > I understand the want for eased development, but couldn't people just
> > > set LD_LIBRARY_PATH instead?
> > 
> > No comments on this?  Should I just send a revert patch instead?

I agree adding . as library path was not a good idea.
This probably is also a potential security issue.

What I do is building the libraries statically into the binary when
testing. I will send a Makefile change introducing a static = true/false
variable to do that easily.

> You can do that.

Thanks for sending the revert, it's the right thing to do.

     Thomas
