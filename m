From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Hibernation considerations
Date: Mon, 16 Jul 2007 10:53:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707161045520.3410-100000__23264.5250660882$1184597702$gmane$org@iolanthe.rowland.org>
References: <200707160802.46567.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707160802.46567.a1426z@gawab.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Al Boldi <a1426z@gawab.com>
Cc: david@lang.hm, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Mon, 16 Jul 2007, Al Boldi wrote:

> From a kexec'd hibernation kernel pov, both S3 and S4 look conceptually 
> exactly the same.  The only difference is, in S3 the memory is in memory and 
> in S4 the memory is on storage.  All device handling is exactly the same, so 
> if there is a problem with device handling between the kexec'd hibernation 
> kernel and the normal kernel, then that would have made itself visible.

You have contradicted yourself.  "In S3 the memory is in memory and in
S4 the memory is on storage".  How does the memory get onto storage?  
The kexec'd hibernation kernel writes it there.  To do so it accesses a 
storage device.

Consequently the device handling _cannot_ be exactly the same in S3 and
S4.

Alan Stern
