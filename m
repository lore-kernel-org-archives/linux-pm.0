From: jfannin@gmail.com (Joseph Fannin)
Subject: Re: Hibernating To Swap Considered Harmful
Date: Tue, 17 Jul 2007 02:28:03 -0400
Message-ID: <20070717062803.GA9069__32174.0429186777$1184653814$gmane$org@nineveh.local>
References: <200707121453.49616.rjw@sisk.pl> <87odig1idx.fsf@jbms.ath.cx>
	<20070717001239.GB20082@nineveh.local>
	<200707170744.08191.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707170744.08191.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: david@lang.hm, linux-kernel@vger.kernel.org, Joseph Fannin <jfannin@gmail.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 17, 2007 at 07:44:07AM +0200, Oliver Neukum wrote:
>
> If yoi want to go the kexec route to hibernation, the dumping kernel
> would need to mount the filesystem to write to a file. Therefore the
> suspending kernel would need to sync to disk and lock that file.

If the file is preallocated, that's not a problem, as there's no need
to touch filesystem metadata.  There'd need to be some channel to pass
the disk blocks that are for writing the image, but that's not going
to be nearly as complicated as passing the current swap data
structures from the previous kernel.

There's no reason to have that file open in the original kernel --
it should be root-owned (it's full of privledged data) and probably
mode 000.

root is free to "dd if=/dev/random of=/dev/mem".  Root owned
daemons which do bad things are bugs.

Again, supporting swap files (*which is not optional*) requires the
very same support.

--
Joseph Fannin
jfannin@gmail.com
