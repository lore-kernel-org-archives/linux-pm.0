From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/2] PM: Wakeup sources and async suspend
	error path bug fix
Date: Thu, 23 Sep 2010 01:00:09 +0200
Message-ID: <201009230100.09867.rjw__14834.8575844013$1285196514$gmane$org@sisk.pl>
References: <201009201957.40995.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201009201957.40995.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, September 20, 2010, Rafael J. Wysocki wrote:
> Hi,
> 
> The following two patches are ready to go into linux-next from my point of
> view, so please let me know if there are any objections:
> 
> [1/2] - PM / Wakeup: Introduce wakeup source objects and event statistics (v3)
> 
> [2/2] - PM: Fix potential issue with failing asynchronous suspend

Due to the apparent lack of objections I applied the patches from this series
to suspend-2.6/linux-next.

Thanks,
Rafael
