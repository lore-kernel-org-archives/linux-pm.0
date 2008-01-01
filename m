From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Hibernation: Document
	__save_processor_state() on x86-64 (rev. 2)
Date: Wed, 2 Jan 2008 00:23:57 +0100
Message-ID: <200801020023.58040.rjw@sisk.pl>
References: <200712302313.52483.rjw@sisk.pl> <20080102000222.GA2404@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080102000222.GA2404@ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@elte.hu>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 2 of January 2008, Pavel Machek wrote:
> On Sun 2007-12-30 23:13:51, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Document the fact that __save_processor_state() has to save all CPU
> > registers referred to by the kernel in case a different kernel is
> > used to load and restore a hibernation image containing it. 
> > 
> > Sigend-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> ACK.

Thanks!

Ingo, can you please take this patch for 2.6.25 or should I forward it to Len?

Rafael
