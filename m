From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 2/4] Hibernation: Arbitrary boot
	kernel support on x86_64
Date: Wed, 22 Aug 2007 10:26:13 +0200
Message-ID: <20070822082613.GB2479__17207.4704235003$1187795247$gmane$org@elf.ucw.cz>
References: <200708221015.16493.rjw@sisk.pl> <200708221019.03798.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200708221019.03798.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed 2007-08-22 10:19:03, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Make it possible to restore a hibernation image on x86_64 with the help of a
> kernel different from the one in the image.
> 
> The idea is to split the core restoration code into two separate parts and to
> place each of them in a different page.  The first part belongs to the boot
> kernel and is executed as the last step of the image kernel's memory restoration
> procedure.  It restores all of the image kernel's memory that has not been
> restored yet except for the one page containing the very code that is being
> executed at that time.  The final operation performed by it is a jump to the
> second part of the core restoration code that belongs to the image kernel and
> has just been restored.  This code restores the last remaining page of the image
> kernel's memory containing the first, already executed, part of the core
> restoration code (temporary page tables created by the boot kernel are used at
> this stage).  It also makes the CPU switch to the image kernel's page tables and
> restores the state of general purpose registers (including the stack pointer)
> from before the hibernation.
> 
> The main issue with this idea is that in order to jump to the second part of the
> restoration code the boot kernel needs to know its address.  However, this
> address may be passed to it in the image header.  Namely, the part of the image
> header previously used for checking if the version of the image kernel is
> correct can be replaced with some architecture specific data that will allow
> the boot kernel to jump to the right address within the image kernel.  These
> data should also be used for checking if the image kernel is compatible with
> the boot kernel (as far as the memory restroration procedure is concerned).
> It can be done, for example, with the help of a "magic" value that has to be
> equal in both kernels, so that they can be regarded as compatible.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
