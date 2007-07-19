From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [RFC] Replacing sysdevs with platform devices
Date: Thu, 19 Jul 2007 10:23:58 +0100
Message-ID: <20070719092358.GC25936@flint.arm.linux.org.uk>
References: <200707181720.17263.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707181720.17263.rjw@sisk.pl>
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
Cc: Andi Kleen <ak@suse.de>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 18, 2007 at 05:20:16PM +0200, Rafael J. Wysocki wrote:
>     Now, on the s3c24xx platforms one sysdev seems to be used for many
>     platform-related operations.  In particular, two or more different sysdev
>     drivers having .suspend() and/or .resume() callbacks defined, related to
>     different parts of the platform, seem to bind to the same sysdev, which is
>     kind of ugly.  It seems to be more correct to have a separate platform
>     device defined for each thing that requires to be suspended late or resumed
>     early and a dedicated platform driver handling these operations.

A suggestion.  The information's all there.  All it takes is to look it
up.

ARM/S3C2410 ARM ARCHITECTURE
P:      Ben Dooks
M:      ben-linux@fluff.org
L:      linux-arm-kernel@lists.arm.linux.org.uk (subscribers-only)
W:      http://www.fluff.org/ben/linux/
S:      Maintained

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
