From: Thomas Renninger <trenn@suse.de>
Subject: Re: [SUBMIT REQUEST] cpupowerutils for linux-next
Date: Mon, 4 Apr 2011 22:14:00 +0200
Message-ID: <201104042214.01501.trenn__39871.1683498279$1301948213$gmane$org@suse.de>
References: <201104041510.56570.trenn@suse.de>
	<20110405004011.0628991a.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110405004011.0628991a.sfr@canb.auug.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Greg Kroah-Hartman <gregkh@novell.com>, Andreas Herrmann <andreas.herrmann3@amd.com>, LKML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Linus <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 04 April 2011 16:40:11 Stephen Rothwell wrote:
> Hi Thomas,
> 
> On Mon, 4 Apr 2011 15:10:56 +0200 Thomas Renninger <trenn@suse.de>
> wrote:
> >
> > this is about the recently announced cpupowerutils project
> > based on or say an enhancement of the well know
> > cpufrequtils project:
> > http://www.spinics.net/lists/cpufreq/msg02137.html
> 
> Has integration of this into the kernel sources been discussed
> anywhere generally (like lkml)?
This is the first submit request.
> Has the work been done to integrate it into the
> kernel build system (I am not sure what this involves for the tools
> directory). 
No, it's separated like perf (but it is by far not that complex and
has not that much dependencies) or like tools/power/x86.

> At a first glance, it doesn't need it own copy of the
> COPYING file (for example).
While cpufrequtils has been developed by people working with
the kernel, there are probably more things like this to clean up
and get adopted.
It would be great to have it in linux-next for a while to get such
stuff addressed and cleaned up.
 
> I see that you asked Linus about this, but have receibed no reply (on
> list).
It was not very clever to simply add Linus into CC of this announcement,
asking for integration in the middle of a merge window...
 
> Code being merged into linux-next should be basically ready for
> merging into Linus' tree (apart from integration testing) and you need
> to be pretty sure that it will be merged by Linus into the next
> release (i.e. 2.6.40).  In this case that is not such a big issue as
> the code is (currently) all in a new directory, so will not interfere
> with other code.
Yes, it's totally separated and will not interfere.
80% of the code (cpufrequtils) is mature and well tested for years.
Recent changes are the cpuidle (cpupower idle-info) and monitor
parts. The integration to have one binary (command subcommand
style like perf/git/guilt/...), invoke manpages via --help, etc.
So yes, the code is ready for getting merged into Linus' tree, still
there hopefully will show up some bugfixes and enhancements
while it lives in linux-next.


    Thomas
