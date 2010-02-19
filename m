From: Tino Keitel <tino.keitel@tikei.de>
Subject: Re: [PATCH] i915 / PM: Fix hibernate regression caused
 by suspend/resume splitting
Date: Fri, 19 Feb 2010 07:39:29 +0100
Message-ID: <20100219063929.GA2851__44431.6707122654$1266600380$gmane$org@x61.home>
References: <74fd948d1002171047g70d2bba0l957e264dfbc8ea23@mail.gmail.com>
	<201002172320.57491.rjw@sisk.pl>
	<74fd948d1002171629v7e86371cna4441e8feb27c326@mail.gmail.com>
	<201002182306.28052.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201002182306.28052.rjw@sisk.pl>
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
Cc: linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>, Pedro Ribeiro <pedrib@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 18, 2010 at 23:06:27 +0100, Rafael J. Wysocki wrote:

[...]

> Jesse, Eric, the appended patch fixes a very recent hibernate regression in
> i915, please push it to Linus ASAP.

FYI: I got no resume failure during normal usage after 9 suspend to RAM
and 8 suspend to disk cycles (using both suspend types alternately)
with the patch applied.

Regards,
Tino
