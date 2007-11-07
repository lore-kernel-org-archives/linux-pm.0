From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH (2.6.25) 0/2] suspend/hibernate Kconfig
	cleanups
Date: Wed, 7 Nov 2007 23:17:47 +0100
Message-ID: <200711072317.48023.rjw@sisk.pl>
References: <20071107135758.100171000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071107135758.100171000@sipsolutions.net>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 7 of November 2007, Johannes Berg wrote:
> These two patches, intended for 2.6.25, clean up the
> suspend/hibernate Kconfig.

Both patches look good.

Since they touch a couple of architectures, I think it's better to merge them
through -mm.

Greetings,
Rafael
