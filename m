From: Jeremy Maitin-Shepard <jbms@cmu.edu>
Subject: Re: Re: Hibernation considerations
Date: Fri, 20 Jul 2007 17:33:55 -0400
Message-ID: <87ejj2pxoc.fsf__39182.3056307205$1184967632$gmane$org@jbms.ath.cx>
References: <Pine.LNX.4.64.0707171319140.2467@asgard.lang.hm>
	<200707201317.58025.rjw@sisk.pl>
	<f29402c6050f9c3ff5d83a59cea2de58@bga.com>
	<200707202328.25126.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707202328.25126.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Fri\, 20 Jul 2007 23\:28\:24 +0200")
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
Cc: David Lang <david@lang.hm>, LKML <linux-kernel@vger.kernel.org>, Milton Miller <miltonm@bga.com>, Ying Huang <ying.huang@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

[snip]

>> Or add a small bit of infrastructure that errors writes at make_request 
>> if you don't have a magic "i am a direct block device write from 
>> userspace" flag on the bio.
>> 
>> The hibernate may fail, but you don't corrupt the media.
>> 
>> If you don't get the image out, resume back to the "this is resume" 
>> instead of the power-down path.

> Well, I don't think that is much prettier than the freezer ...

It seems that a better solution to the "how do we write to a file on an
in-use partition" has been suggested, which also handles swap partitions
and swap files, and does not require mounting filesystems, so it seems
that the filesystem issue need not be considered.

[snip]

> No.  I'm saying that when you go back from the image-saving kernel to the
> hibernated kernel, you need to make sure that no task will cause any
> filesystem's on-disk state to be actually updated.  If you can't make such
> a guarantee, you just can't do that.

> With the current state of the drivers, it's not doable without the
> freezer.

It seems that it should be feasible to fix the drivers so that

1. they can be taken from normal state to quiesced state without
   requiring the freezer;

2. they can be taken from normal state to low power state without
   requiring the freezer;

3. they can be taken from quiesced state to low power state without
   requiring the freezer.

In the particular, it seems that it should be possible to do (3) without
needing to schedule tasks.

It seems likely that (2) may in fact be almost exactly the same as, or
at least similar to, (1) followed by (3), at least for many drivers.
(1) is required by the kexec hibernate approach even ignoring suspend to
both or S4.  (2) is required for suspend to ram without the freezer,
which seems to be desired anyway.

[snip]

-- 
Jeremy Maitin-Shepard
