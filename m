From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] Kexec jump: Hibernation image operations
Date: Thu, 12 Jul 2007 22:54:15 +0200
Message-ID: <200707122254.16695.rjw__46225.1598052264$1184273447$gmane$org@sisk.pl>
References: <1184167834.12556.14.camel@caritas-dev.intel.com>
	<20070712093808.GF1866@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070712093808.GF1866@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, "Huang, Ying" <ying.huang@intel.com>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Thursday, 12 July 2007 11:38, Pavel Machek wrote:
> On Wed 2007-07-11 15:30:34, Huang, Ying wrote:
> > This patch make it possible to have multiple implementations of
> > hibernation image operations such as write, read, check, etc, and they
> > can be switched at run time through writing the
> > "/sys/power/hibernation_image_ops". The uswsusp is the default
> > implementation.
> 
> Umm, so you hook into hibernation_ops, only to run kexec from it?
> 
> Would it make more sense to just run kexec manually, maybe with some
> parameter saying "prepare devices before"?

Well, I think that the $subject patch is unnecessary and confusing.  Instead,
I'd like to have a separate interface to invoke the feature provided by the
second patch.

What the second patch achieves, as far as I understand it, is the ability to be
able to jump between two kernels back and forth, on i386.  Although it may
generally be useful for hibernation, IMO it has very little to it right now,
because _many_ important elements of the infrastructure are still needed.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
