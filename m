From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] Replacing sysdevs with platform devices
Date: Thu, 19 Jul 2007 11:39:42 +0200
Message-ID: <200707191139.43138.rjw@sisk.pl>
References: <200707181720.17263.rjw@sisk.pl>
	<20070719092358.GC25936@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070719092358.GC25936@flint.arm.linux.org.uk>
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
To: Russell King <rmk@arm.linux.org.uk>
Cc: Andi Kleen <ak@suse.de>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, 19 July 2007 11:23, Russell King wrote:
> On Wed, Jul 18, 2007 at 05:20:16PM +0200, Rafael J. Wysocki wrote:
> >     Now, on the s3c24xx platforms one sysdev seems to be used for many
> >     platform-related operations.  In particular, two or more different sysdev
> >     drivers having .suspend() and/or .resume() callbacks defined, related to
> >     different parts of the platform, seem to bind to the same sysdev, which is
> >     kind of ugly.  It seems to be more correct to have a separate platform
> >     device defined for each thing that requires to be suspended late or resumed
> >     early and a dedicated platform driver handling these operations.
> 
> A suggestion.  The information's all there.  All it takes is to look it
> up.
> 
> ARM/S3C2410 ARM ARCHITECTURE
> P:      Ben Dooks
> M:      ben-linux@fluff.org
> L:      linux-arm-kernel@lists.arm.linux.org.uk (subscribers-only)
> W:      http://www.fluff.org/ben/linux/
> S:      Maintained

OK, thanks.
