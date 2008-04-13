From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend and
 hibernation callbacks (rev. 8)
Date: Sun, 13 Apr 2008 19:23:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0804131916420.3060-100000__44684.1659294025$1208129102$gmane$org@netrider.rowland.org>
References: <1208128289.29577.25.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1208128289.29577.25.camel@nigel-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 14 Apr 2008, Nigel Cunningham wrote:

> > The ability for prepare() callbacks to sync with userland,
> > request_firmware, etc... is an important feature that's been needed for
> > some time imho.
> > 
> > Ben.
> 
> I agree. These calls have already been changing far too often in
> mainline. I know it's all been necessary but please, can we try to make
> one set of changes and just get it right this time?

In practical terms, it will be easier to keep the freezer where it is 
for now.  This is because prepare() requires drivers to change their 
behavior; they aren't allowed to register new children any more.

But if userspace isn't frozen then user programs can interact with
drivers in a way that does cause new children to be created.  For
example this happens in USB, where opening an audio device and
selecting its bitrate causes a new set of endpoints to be realized,
along with their representations in sysfs.

Thus, in addition to making all the interface changes implied by the 
new callbacks, drivers would also have to change the way they interact 
with userspace.  Yes, this will have to be done eventually in any case, 
as the freezer goes away -- but it shouldn't have to be done right now.

Alan Stern
