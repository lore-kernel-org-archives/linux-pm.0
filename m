From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Hibernation considerations
Date: Sun, 15 Jul 2007 14:33:32 +0200
Message-ID: <200707151433.34625.rjw__25698.1922816069$1184502653$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: LKML <linux-kernel@vger.kernel.org>
Cc: david@lang.hm, Kyle Moffett <mrmacman_g4@mac.com>, Al Boldi <a1426z@gawab.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Hi,

Since many alternative approaches to hibernation are now being considered and
discussed, I thought it might be a good idea to list some things that in my not
so humble opinion should be taken care of by any hibernation framework.  They
are listed below, not in any particular order, because I think they all are
important.  Still, I might have forgotten something, so everyone with
experience in implementing hibernation, especially Pavel and Nigel, please
check if the list is complete.

(1) Filesystems mounted before the hibernation are untouchable

    When there's a memory snapshot, either in the form of a hibernation image,
    or in the form of the "old" kernel and processes available to the "new"
    kexeced kernel responsible for saving their memory, the filesystems mounted
    before the hibernation should not be accessed, even for reading, because
    that would cause their on-disk state to be inconsistent with the snapshot
    and might lead to a filesystem corruption.

(2) Swap space in use before the hibernation must be handled with care

    If swap space is used for saving the memory snapshot, the snapshot-saving
    application (or kernel) must be careful enough not to overwrite swap pages
    that contain valid memory contents stored in there before the hibernation.

(3) There are memory regions that must not be saved or restored

    Some memory regions contain data that shouldn't be overwritten during the
    restore, because that might lead to the system not working correctly
    afterwards.  Also, on some systems there are valid 'struct pages'
    structures that in fact corresond to memory holes and we should not attempt
    to save those pages.

(4) The user should be able to limit the size of a hibernation image

    There are a couple of reasons of that.  For example, the storage space
    used for saving the image may be smaller than the entire RAM or the user
    may want the image to be saved quickier.

(5) Hibernation should be transparent from the applications' point of view

    Generally, applications should not notice that hibernation took place.
    [Note that I don't regard all processes as applications and I think that
    there may be processes which need to handle the hibernation in a special
    way.]  Ideally, for example, if some audio is being played when a
    hibernation starts, the audio player should be able to continue playing the
    same audio after the restore from the point in which it has been
    interrupted by the hibernation.  Also, the CPU affinities and similar
    settings requested by the applications before a hibernation should be
    binding after the restore.

(6) State of devices from before hibernation should be restored, if possible

    If possible, during a restore devices should be brought back to the same
    state in which they were before the corresponding hibernation.  Of course
    in some situations it might be impossible to do that (eg. the user
    connected the hibernated system to a different IP subnet and then
    restored), but as a general rule, we should do our best to restore the
    state of devices, which is directly related to point (5) above.

(7) On ACPI systems special platform-related actions have to be carried out at
    the right points, so that the platform works correctly after the restore

    The ACPI specification requires us to invoke some global ACPI methods
    during the hibernation and during the restore.  Moreover, the ordering of
    code related to these ACPI methods may not be arbitrary (eg. some of
    them have to be executed after devices are put into low power states etc.).

(8) Hibernation and restore should not be too slow

    In my opinion, if more than one minute is needed to hibernate the system
    with the help of certain hibernation framework, then this framework is not
    very useful in practice.  It might be useful to perform some special tasks
    (eg. moving a server to another place without taking it down), but it is
    not very useful, for example, to notebook users.

(9) Hibernation framework should not be too difficult to set up

    It follows from my experience that if the users are required to do too much
    work to set up a hibernation framework, they will not use it as long as
    there are simpler alternatives (some of them will not use hibernation at
    all if it's too difficult to get to work).  On the other hand, if the users
    are provided with a working hibernation framework by their distribution
    and they find it useful, they are not likely to use kernel.org kernels if
    t's too difficult to replace the distribution kernel with a generic one due
    to the hibernation framework's requirements.

All of the existing hibernation frameworks have been written with the above
points in mind and that's why they are what they are.  In particular, the
existence of the tasks freezer, hated by some people to the point of insanity,
follows directly from points (1), (4) and (5).

In my opinion any hibernation framework that doesn't take the above
requirements into account in any way will be a failure.  Moreover, the existing
frameworks fail to follow some of them too, so I consider all of these
frameworks as a work in progress.  For this reason, I will much more appreciate
ideas allowing us to improve the existing frameworks in a more or less
evolutionary way, then attempts to replace them all with something entirely
new.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
