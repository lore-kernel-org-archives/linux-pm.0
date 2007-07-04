From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 12:33:17 +0200
Message-ID: <200707041233.18199.rjw@sisk.pl>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707032332.49694.rjw@sisk.pl>
	<18059.5165.861038.392332@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <18059.5165.861038.392332@cargo.ozlabs.ibm.com>
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
To: Paul Mackerras <paulus@samba.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 4 July 2007 05:29, Paul Mackerras wrote:
> Rafael J. Wysocki writes:
> 
> > Still, do you really think that we're ready to drop it _right_ _now_ (I'm
> > referring to suspend only) and if so than on what basis (except that you
> > don't like it, which falls short of being a techical argument)?
> 
> The basis is that it (the freezer) causes more deadlocks and other
> problems than it avoids, so it's a net win to remove it.

So, I gather, you're volunteering to handle suspend-related bug reports
from the point in which we drop the freezer from the suspend code path?

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
