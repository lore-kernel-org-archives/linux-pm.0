From: Al Boldi <a1426z@gawab.com>
Subject: Re: Hibernation considerations
Date: Mon, 16 Jul 2007 19:51:35 +0300
Message-ID: <200707161951.35225.a1426z__46194.051000248$1184604879$gmane$org@gawab.com>
References: <Pine.LNX.4.44L0.0707161045520.3410-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707161045520.3410-100000@iolanthe.rowland.org>
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
> On Mon, 16 Jul 2007, Al Boldi wrote:
> > From a kexec'd hibernation kernel pov, both S3 and S4 look conceptually
> > exactly the same.  The only difference is, in S3 the memory is in memory
> > and in S4 the memory is on storage.  All device handling is exactly the
> > same, so if there is a problem with device handling between the kexec'd
> > hibernation kernel and the normal kernel, then that would have made
> > itself visible.
>
> You have contradicted yourself.  "In S3 the memory is in memory and in
> S4 the memory is on storage".  How does the memory get onto storage?
> The kexec'd hibernation kernel writes it there.  To do so it accesses a
> storage device.
>
> Consequently the device handling _cannot_ be exactly the same in S3 and
> S4.

Ok, you should have read this in the context of suspending/resuming from/to 
the normal kernel, and in that case they are exactly the same, i.e. kexec -e 
for suspend and kexec -j for resume.

BTW, it would be really helpful if people would actually try the kexec 
hibernation patches, as this may yield a much more constructive discussion.


Thanks!

--
Al
