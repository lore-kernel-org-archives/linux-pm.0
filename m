From: sriram@marirs.net.in
Subject: Re: Bad rpath in cpupower with 4.0-rcX
Date: Wed, 11 Mar 2015 17:50:40 +0530
Message-ID: <1426076440.1521674.238850889.75B44828@webmail.messagingengine.com>
References: <20150306134745.GC4801@hansolo.redhat.com>
 <CA+5PVA6Jo9LTbhduCs0eYXJxmdG-39PR-fOKmABNLO2F3btXUA@mail.gmail.com>
 <15697793.jrEQ5UURAe@vostro.rjw.lan> <3001692.z661NIszxI@skinner>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3001692.z661NIszxI@skinner>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Josh Boyer <jwboyer@fedoraproject.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Sorry for the change. 

On Wed, Mar 11, 2015, at 05:23 PM, Thomas Renninger wrote:
> On Tuesday, March 10, 2015 11:30:44 PM Rafael J. Wysocki wrote:
> > On Tuesday, March 10, 2015 08:33:54 AM Josh Boyer wrote:
> > > On Fri, Mar 6, 2015 at 8:47 AM, Josh Boyer <jwboyer@fedoraproject.org> 
> wrote:
> > > > Hi All,
> > > > 
> > > > Commit 5c1de006e8e66 (cpupower Makefile change to help run the tool
> > > > without 'make install') added an rpath to the cpupower binary.  From
> > > > what I can understand, this is to make it easier to run cpupower from
> > > > the local build directory without having to run make install.  It does
> > > > accomplish that, but it also leaves the binary with the rpath in it
> > > > which is considered bad practice.  It also causes cpupower to fail in
> > > > rpmbuild with the following error:
> > > > 
> > > > ERROR   0004: file '/usr/bin/cpupower' contains an insecure rpath './'
> > > > in [./]
> > > > error: Bad exit status from /var/tmp/rpm-tmp.A6u26r (%install)
> > > > 
> > > >     Bad exit status from /var/tmp/rpm-tmp.A6u26r (%install)
> > > > 
> > > > I understand the want for eased development, but couldn't people just
> > > > set LD_LIBRARY_PATH instead?
> > > 
> > > No comments on this?  Should I just send a revert patch instead?
> 
> I agree adding . as library path was not a good idea.
> This probably is also a potential security issue.
> 
> What I do is building the libraries statically into the binary when
> testing. I will send a Makefile change introducing a static = true/false
> variable to do that easily.
> 
> > You can do that.
> 
> Thanks for sending the revert, it's the right thing to do.
> 
>      Thomas
