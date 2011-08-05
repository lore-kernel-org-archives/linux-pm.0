From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 02/11] PM: extend PM QoS with per-device
 wake-up constraints
Date: Sat, 6 Aug 2011 01:11:49 +0900
Message-ID: <20110805161147.GA3438__37142.196778632$1312560776$gmane$org@opensource.wolfsonmicro.com>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com>
	<201108030016.18174.rjw@sisk.pl>
	<20110804132426.GB14921@sirena.org.uk>
	<201108042115.30983.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201108042115.30983.rjw@sisk.pl>
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
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 04, 2011 at 09:15:30PM +0200, Rafael J. Wysocki wrote:
> On Thursday, August 04, 2011, Mark Brown wrote:

> > On the one hand that's true.  On the other hand that just seems like
> > going down a bad road where we have drivers that only work when run with
> > a magic userspace that may or may not be published which is just going

> First off, we're doing this already (user space can block runtime PM, for
> one example, because there are systems where runtime PM doesn't work
> although it works on other systems with analogous hardware and pretty
> much the same set of drivers).

Yeah, I've never been terribly convinced about that and for the things
that drivers need to manualy implement (like wake configuration) it's
widely ignored.

> Second, I think there are valid use cases in which user space _really_ knows
> better than the kernel.  I'm opposed to the idea that users shouldn't be given
> control of their systems, because they may not know what they're doing.

Do you have any examples of this that aren't better expressed in device
specific terms?  It's not that users don't know what they're doing, it's
that working around system integration and stability issues in userspace
isn't really progressing things well or helping with maintainability.
Generally if the user has sufficient access to be able to do anything
with this stuff they've got just as much access to the kernel as to
userspace.
