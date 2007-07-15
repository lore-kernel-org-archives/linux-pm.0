From: david@lang.hm
Subject: Re: Hibernation considerations
Date: Sun, 15 Jul 2007 13:13:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707151253141.25614@asgard.lang.hm>
References: <200707151433.34625.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707151433.34625.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Al Boldi <a1426z@gawab.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Sun, 15 Jul 2007, Rafael J. Wysocki wrote:

> Hi,
>
> Since many alternative approaches to hibernation are now being considered and
> discussed, I thought it might be a good idea to list some things that in my not
> so humble opinion should be taken care of by any hibernation framework.  They
> are listed below, not in any particular order, because I think they all are
> important.  Still, I might have forgotten something, so everyone with
> experience in implementing hibernation, especially Pavel and Nigel, please
> check if the list is complete.
>
> (1) Filesystems mounted before the hibernation are untouchable
>
>    When there's a memory snapshot, either in the form of a hibernation image,
>    or in the form of the "old" kernel and processes available to the "new"
>    kexeced kernel responsible for saving their memory, the filesystems mounted
>    before the hibernation should not be accessed, even for reading, because
>    that would cause their on-disk state to be inconsistent with the snapshot
>    and might lead to a filesystem corruption.

AFAIK this is only the case with ext3, all other filesystems could be 
accessed read-only safely

this is arguably a bug with ext3 (and has been discussed as such), but 
right now the ext3 team has decided not to change this bahavior so 
hibernate needs to work around it. but don't mistake a work-around for a 
single (admittedly very popular) filesystem with a hard and fast 
directive.

> (2) Swap space in use before the hibernation must be handled with care
>
>    If swap space is used for saving the memory snapshot, the snapshot-saving
>    application (or kernel) must be careful enough not to overwrite swap pages
>    that contain valid memory contents stored in there before the hibernation.

true, in fact, given that many distros and live-CD's autodetect swap 
partitions and consider them fair game, I would argue that the best thing 
to do would be to have the main system free up it's swap partitions before 
going into hibernation.

however, this could be a decision of the particular hibernate routines.

for the kexec approach the mapping of what swap pages are in use is one 
more chunk of data that needs to be assembled and made available through a 
defined interface.

> (4) The user should be able to limit the size of a hibernation image
>
>    There are a couple of reasons of that.  For example, the storage space
>    used for saving the image may be smaller than the entire RAM or the user
>    may want the image to be saved quickier.

it may make sense for this to be split into hard and soft limits.

if you try to save more then the storage space can hold you cannot 
continue, but if you are just a little over the arbatrary size limit that 
was set to make things fast you are better off saving things as-is then 
punting, going back to the system, trying to free more ram, and trying a 
hibernate again.

with the kexec approach the enforcment of these limits is also split into 
two sections.

when the hibernate command is given in the main kernel, it's userspace 
needs to follow some policy to decide how much (if any) memory to free.

this could be anything from 'none, try and save all caches' to 'anything 
you can to minimize the amount of data to be saved, trash all caches' to 
something in between like 'try and free up enough memory to get the saved 
data below 1G, but save caches beyond that point'

then when the second kernel runs, it's userspace tools get the list of 
what memory should be saved that the main kernel handed to it, and then 
decides if this is acceptable (probably mostly the hard limits of 'can 
this work') and proceeds to save it somewhere.

but since the kexec command and the preporation of the devices can change 
the memory, the estimates done by the first kernel's userspace are just 
that, estimates.

> (7) On ACPI systems special platform-related actions have to be carried out at
>    the right points, so that the platform works correctly after the restore
>
>    The ACPI specification requires us to invoke some global ACPI methods
>    during the hibernation and during the restore.  Moreover, the ordering of
>    code related to these ACPI methods may not be arbitrary (eg. some of
>    them have to be executed after devices are put into low power states etc.).

for a pure hibernate mode, you will be powering off the box after saving 
the suspend image. why are there any special ACPI modes involved?

now, for suspend-to-ram you need to be aware of every possible power 
saving option you have and the cost of each of them, and here the ACPI 
modes are heavily used.

I think this is mixing suspend and hibernate still.

David Lang
