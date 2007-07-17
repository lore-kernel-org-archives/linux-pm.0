From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Hibernating To Swap Considered Harmful
Date: Tue, 17 Jul 2007 07:44:07 +0200
Message-ID: <200707170744.08191.oliver__18177.4759119891$1184651013$gmane$org@neukum.org>
References: <200707121453.49616.rjw@sisk.pl> <87odig1idx.fsf@jbms.ath.cx>
	<20070717001239.GB20082@nineveh.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070717001239.GB20082@nineveh.local>
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
To: Joseph Fannin <jfannin@gmail.com>
Cc: david@lang.hm, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Am Dienstag 17 Juli 2007 schrieb Joseph Fannin:
> Why are all these workarounds preferred, instead of proper suspend
> support for swap files?
> 
> IOW, what reasons are there to *not* support swap files, other than the
> hit-and-miss Linux suspend support?

If yoi want to go the kexec route to hibernation, the dumping kernel
would need to mount the filesystem to write to a file. Therefore the
suspending kernel would need to sync to disk and lock that file.

	Regards
		Oliver
