From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: intermittent suspend problem again
Date: Fri, 30 Oct 2009 21:38:37 +0100
Message-ID: <200910302138.37938.rjw__21078.5145326101$1256935100$gmane$org@sisk.pl>
References: <87fx93pwv2.fsf@tac.ki.iif.hu> <200910301918.53301.rjw@sisk.pl>
	<87k4yc3drd.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87k4yc3drd.fsf@tac.ki.iif.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, yakui.zhao@intel.com, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday 30 October 2009, Ferenc Wagner wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> 
> > On Thursday 29 October 2009, Ferenc Wagner wrote:
> >
> >> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> >> 
> >>> Which part of it is getting slower?  Saving the image, suspending
> >>> devices or the entire hibernation overall?
> >> 
> >> "Snapshotting system" before saving the image
> >
> > That may be a result of changing the way in which image memory is reserved.
> > How much memory is there in your machine?
> 
> 512 MB.

So it's likely the slowdown results from the memory management rework.
Hopefully, it'll improve in the future.

> >> and saving the image as well.  If s2disk didn't report funny huge negative
> >> ratios all the time,
> >
> > Hmm.  This looks like a bug in s2disk.
> 
> Definitely.  Do you also experience this?

Not really, but I use newer versions.

> Probably an easy one, but I've never had the chance to check the CVS version
> (running 0.7 at the moment).  I can probably give 0.8 a spin if you deem
> necessary.  I always thought it wasn't more than a cosmetic flaw.

It probably is.  You can try the current version from my git tree at:
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-utils.git

Thanks,
Rafael
