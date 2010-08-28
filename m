From: Pavel Machek <pavel@ucw.cz>
Subject: Re: BUG: scheduling while atomic
Date: Sat, 28 Aug 2010 08:42:54 +0200
Message-ID: <20100828064254.GA2128__32909.8062277355$1282977847$gmane$org@elf.ucw.cz>
References: <20100827075911.GA5966@swordfish.minsk.epam.com>
	<201008272102.52041.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201008272102.52041.rjw@sisk.pl>
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
Cc: Lin Ming <ming.m.lin@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri 2010-08-27 21:02:51, Rafael J. Wysocki wrote:
> On Friday, August 27, 2010, Sergey Senozhatsky wrote:
> > Hello,
> > 
> > .36-rc2-git4
> 
> Well, that looks like an ACPI battery driver issue.
> 
> What was the last know good kernel?

Also you might want to see if unloading battery driver before hibernation
allows you do proceed...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
