From: Greg KH <gregkh@suse.de>
Subject: Re: [RFC][PATCH 2/2] Convert several sysdev users to
 using struct syscore_ops
Date: Fri, 11 Mar 2011 09:12:31 -0800
Message-ID: <20110311171231.GB10437__26706.3932995827$1299863659$gmane$org@suse.de>
References: <201103100131.58206.rjw@sisk.pl> <201103100134.02675.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201103100134.02675.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, mingo@redhat.com, "H. Peter Anvin" <hpa@zytor.com>, Kay Sievers <kay.sievers@suse.de>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, tglx@linutronix.de
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 10, 2011 at 01:34:02AM +0100, Rafael J. Wysocki wrote:
> Some subsystems need to carry out suspend/resume and shutdown
> operations with one CPU on-line and interrupts disabled and they
> define sysdev classes and sysdevs specifically for this purpose.
> This leads to unnecessarily complicated code and excessive memory
> usage, so switch them to using struct syscore_ops objects for this
> purpose instead.

Heavily-Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

:)

Do you want to resend this with a signed-off-by and your first one so I
can apply it to my tree, or do you want to take it through yours?

thanks again for doing this.

greg k-h
