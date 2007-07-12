From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] Kexec jump: Hibernation image operations
Date: Thu, 12 Jul 2007 11:38:08 +0200
Message-ID: <20070712093808.GF1866@elf.ucw.cz>
References: <1184167834.12556.14.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1184167834.12556.14.camel@caritas-dev.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Wed 2007-07-11 15:30:34, Huang, Ying wrote:
> This patch make it possible to have multiple implementations of
> hibernation image operations such as write, read, check, etc, and they
> can be switched at run time through writing the
> "/sys/power/hibernation_image_ops". The uswsusp is the default
> implementation.

Umm, so you hook into hibernation_ops, only to run kexec from it?

Would it make more sense to just run kexec manually, maybe with some
parameter saying "prepare devices before"?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
