From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 2/9] PM/resume: wait for device probing to
	finish
Date: Fri, 13 Feb 2009 17:48:13 -0800
Message-ID: <20090214014813.GB17975__22805.0815909684$1234576608$gmane$org@suse.de>
References: <200902140157.40869.rjw@sisk.pl> <200902140200.21022.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200902140200.21022.rjw@sisk.pl>
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
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, Arjan van de Ven <arjan@linux.intel.com>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, Masami Hiramatsu <mhiramat@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Sat, Feb 14, 2009 at 02:00:19AM +0100, Rafael J. Wysocki wrote:
> From: Arjan van de Ven <arjan@linux.intel.com>
> 
> the resume code does not currently wait for device probing to finish.
> Even without async function calls this is dicey and not correct,
> but with async function calls during the boot sequence this is going
> to get hit more...
> 
> This patch adds the synchronization using the newly introduced helper.
> 
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Fine with me if this goes through Len's tree.

thanks,

greg k-h
