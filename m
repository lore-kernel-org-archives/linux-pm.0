From: Al Boldi <a1426z@gawab.com>
Subject: Re: Hibernation considerations
Date: Mon, 16 Jul 2007 08:02:46 +0300
Message-ID: <200707160802.46567.a1426z__39677.6744434193$1184562434$gmane$org@gawab.com>
References: <Pine.LNX.4.44L0.0707151918340.30402-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707151918340.30402-100000@netrider.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: david@lang.hm, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Alan Stern wrote:
> As for the VGA font, the effect is easy to see: Run setfont before
> hibernating; when you resume the original font will be back.  The
> kernel simply does not bother to save the VGA font information across a
> hibernate.

This could probably be handled by a device suspend/resume call; but this 
problem is not specific to kexec.

> > Ok, after applying the latest kexec patches, I was able to use the
> > kexec'd kernel to suspend to ram and resume to the normal kernel, while
> > working under a full-blown X session.  It went without a hitch.  All
> > that is needed now are the dump/restore hibernation-image routines.
>
> That's exactly my point.  While doing suspend-to-RAM from a kexec'd
> kernel may be simple, saving the hibernation image will add
> complications.

>From a kexec'd hibernation kernel pov, both S3 and S4 look conceptually 
exactly the same.  The only difference is, in S3 the memory is in memory and 
in S4 the memory is on storage.  All device handling is exactly the same, so 
if there is a problem with device handling between the kexec'd hibernation 
kernel and the normal kernel, then that would have made itself visible.

david@lang.hm wrote:
> suspend-to-RAM should not involve kexec, the only reason for doing the
> kexec to to get a seperate userspace to use for suspend-to-disk operations
> instead of trying to partially freeze the sustem and keep useing it.

Or you could do suspend-to-disk-and-RAM.  But in the above case, it was meant 
to test kexec compatibility with device suspend/resume calls.


Thanks!

--
Al
