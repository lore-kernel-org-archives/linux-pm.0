From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Macbook 5,1 Ubuntu Lucid resume issue
Date: Fri, 5 Feb 2010 23:10:13 +0100
Message-ID: <201002052310.14021.rjw@sisk.pl>
References: <1265306675.1951.14.camel@cndougla-ubuntu>
	<201002042305.16871.rjw@sisk.pl>
	<1265324443.1951.19.camel@cndougla-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1265324443.1951.19.camel@cndougla-ubuntu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday 05 February 2010, Chase Douglas wrote:
> On Thu, 2010-02-04 at 23:05 +0100, Rafael J. Wysocki wrote:
> > On Thursday 04 February 2010, Chase Douglas wrote:
> > > Hello all,
> > > 
> > > I'm testing resume from s3 suspend on Ubuntu Lucid on my macbook
> > > (version 5,1; nvidia MCP 79 internals). On Ubuntu Karmic, resume
> > > (usually) works without a hitch. However, on Lucid when I resume the
> > > disk resumes and the system is partly running, but the display
> > > (backlight and LCD I think) and ethernet networking do not come back up.
> > > This occurs when resuming back to X or to a virtual terminal without X
> > > started. It occurs whether the nvidia or nv kernel modules are loaded or
> > > unloaded.
> > > 
> > > What is most interesting is the dependent variable in all of this is not
> > > the kernel but the user-space. If I run Karmic with the Lucid kernel it
> > > resumes correctly. If I run Lucid with the Karmic kernel it does not
> > > resume correctly. I have run a script which essentially does:
> > > 
> > > 1. suspend (using pm-suspend)
> > > 2. wait 60 seconds (during which time I resume the machine)
> > > 3. save dmesg output to the hard disk
> > > 
> > > I have pored over the dmesg logs from good and bad resumes, but I
> > > haven't found anything to suggest what the real issue may be. Right now
> > > I am at a loss as to what I should try next. Does anyone have any
> > > thoughts as to what I can try to debug this?
> > 
> > It sounds like the distro is using a specific user-space quirk to handle your
> > machine.
> > 
> > Please try if the machine can be suspended by "echo mem > /sys/power/state"
> > and resumed correctly.
> 
> I have, but the results are the same.

Do you use s2disk for hibernation?

Rafael
