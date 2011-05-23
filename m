From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH] ARM hibernation /
	suspend-to-disk	support code
Date: Mon, 23 May 2011 15:32:17 +0100
Message-ID: <20110523143216.GA14131@n2100.arm.linux.org.uk>
References: <3DCE2F529B282E4B8F53D4D8AA406A07014FFE@008-AM1MPN1-022.mgdnok.nokia.com>
	<20110520113758.GA3141@arm.com>
	<alpine.DEB.2.00.1105201255260.8018@localhost6.localdomain6>
	<201105210027.17159.rjw@sisk.pl> <20110523095232.GB2370@arm.com>
	<alpine.DEB.2.00.1105231239270.8018@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1105231239270.8018@localhost6.localdomain6>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Frank Hofmann <frank.hofmann@tomtom.com>
Cc: Dave Martin <dave.martin@linaro.org>, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, tuxonice-devel@tuxonice.net
List-Id: linux-pm@vger.kernel.org

On Mon, May 23, 2011 at 02:37:19PM +0100, Frank Hofmann wrote:
> What I've found necessary to save/restore via swsusp_arch_suspend/resume  
> are the SYSTEM_MODE and SVC_MODE registers.
> Yesterday, I had thought that cpu_init() resets SVC_MODE sufficiently but 
> that doesn't seem to be the case, if I leave that out, resume-from-disk  
> doesn't work anymore.

You will be running in SVC mode, so the SVC mode registers are your
current register set.  At some point you need to do an effective
"context switch" between the kernel doing the resume and the kernel
which was running.  That involves restoring the saved register state.

System mode on the other hand is unused by the kernel.
