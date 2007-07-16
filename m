From: Richard Hughes <hughsient@gmail.com>
Subject: Re: add powerbutton and lid platform devices
Date: Mon, 16 Jul 2007 09:51:01 +0100
Message-ID: <1184575861.2228.39.camel__1205.03288130767$1184605466$gmane$org@work>
References: <20070330235759.GC4252@cosmic.amd.com>
	<20070708221027.GA4964@dmt> <20070709150545.GD31533@cosmic.amd.com>
	<200707090930.26973.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707090930.26973.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.linux-foundation.org, devel@laptop.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2007-07-09 at 09:30 -0700, David Brownell wrote:
> What's this "power manager" component?

At the moment we're using OHM, although it's got a few rough edges, it
seems to do mostly what we need it to right now.

> This policy is easily set through sysfs.  It doesn't need a new
> component to make that decision.

Sure you do. What happens if you are right in the middle of a system
update over wifi -- do you still want to suspend in that case? Or a bios
flash? There has to be something higher level to unset or set the policy
knobs in the kernel with the information from the system or session.

Richard.
