From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Bad rpath in cpupower with 4.0-rcX
Date: Tue, 10 Mar 2015 23:30:44 +0100
Message-ID: <15697793.jrEQ5UURAe@vostro.rjw.lan>
References: <20150306134745.GC4801@hansolo.redhat.com> <CA+5PVA6Jo9LTbhduCs0eYXJxmdG-39PR-fOKmABNLO2F3btXUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60066 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752477AbbCJWHA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2015 18:07:00 -0400
In-Reply-To: <CA+5PVA6Jo9LTbhduCs0eYXJxmdG-39PR-fOKmABNLO2F3btXUA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Josh Boyer <jwboyer@fedoraproject.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Thomas Renninger <trenn@suse.de>, "sriram@marirs.net.in" <sriram@marirs.net.in>, Linux PM list <linux-pm@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>

On Tuesday, March 10, 2015 08:33:54 AM Josh Boyer wrote:
> On Fri, Mar 6, 2015 at 8:47 AM, Josh Boyer <jwboyer@fedoraproject.org> wrote:
> > Hi All,
> >
> > Commit 5c1de006e8e66 (cpupower Makefile change to help run the tool
> > without 'make install') added an rpath to the cpupower binary.  From
> > what I can understand, this is to make it easier to run cpupower from
> > the local build directory without having to run make install.  It does
> > accomplish that, but it also leaves the binary with the rpath in it
> > which is considered bad practice.  It also causes cpupower to fail in
> > rpmbuild with the following error:
> >
> > ERROR   0004: file '/usr/bin/cpupower' contains an insecure rpath './'
> > in [./]
> > error: Bad exit status from /var/tmp/rpm-tmp.A6u26r (%install)
> >     Bad exit status from /var/tmp/rpm-tmp.A6u26r (%install)
> >
> > I understand the want for eased development, but couldn't people just
> > set LD_LIBRARY_PATH instead?
> 
> No comments on this?  Should I just send a revert patch instead?

You can do that.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
