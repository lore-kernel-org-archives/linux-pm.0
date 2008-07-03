From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Handling of suspend/hibernation patches
Date: Thu, 3 Jul 2008 23:18:40 +0200
Message-ID: <200807032318.41446.rjw__5346.26780213348$1215120034$gmane$org@sisk.pl>
References: <200807032247.34049.rjw@sisk.pl>
	<20080703140154.18876f5a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080703140154.18876f5a.akpm@linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, jbarnes@virtuousgeek.org, linux-acpi@vger.kernel.org, pavel@suse.cz, andi@firstfloor.org, linux-pm@lists.linux-foundation.org, torvalds@linux-foundation.org, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

On Thursday, 3 of July 2008, Andrew Morton wrote:
> On Thu, 3 Jul 2008 22:47:32 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > Hi,
> > 
> > Recently, we've had some problems with the handling of suspend/hibernation
> > patches, because they tend to touch multiple subsystems at a time.  As a
> > result, it usually is not clear which tree they should be included in and at
> > the moment there are suspend/hibernation patches in the PCI, ACPI, x86
> > trees, as well as in -mm.  Of course the resulting dependencies between those
> > trees are a pain to Stephen and their maintainers.
> > 
> > After the last Kernel Summit we tried to create a branch in the ACPI tree for
> > suspend/hibernation patches (thanks Len!) and that had worked quite well until
> > we started to work on the core device power management.  This coincided with
> > the creation of linux-next and collecting suspend/hibernation patches in the
> > ACPI tree became inconvenient.
> > 
> > Now, we could go back to the old way of handling suspend/hibernation patches,
> > which was to merge them through -mm, but the disadvantage of this would be that
> > the patches wouldn't go through linux-next.  However, I'd like
> > suspend/hibernation patches to be included in linux-next, so that they can get
> > as much testing as possible.
> 
> I need to get butt into gear and get most-of-mm into linux-next.  I'll
> be picking that up when 2.6.27-rc1 is done.
> 
> So we can just keep this tree in -mm (and hence linux-next) if you like.

Well, that will save me quite a bit patch management work. :-)

Let's keep that in -mm, then.

Thanks,
Rafael
