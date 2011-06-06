From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: calling runtime PM from system PM methods
Date: Mon, 6 Jun 2011 20:01:50 +0200
Message-ID: <201106062001.50969.rjw__48674.830972641$1307383306$gmane$org@sisk.pl>
References: <87k4d55c8k.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87k4d55c8k.fsf@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@ti.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, June 02, 2011, Kevin Hilman wrote:
> Hi Rafael,

Hi,

> Once again, I'm back to some problems with using runtime PM from system
> PM methods.  On OMAP, many drivers don't need to do anything different
> for runtime PM compared to system PM, so the system PM methods can
> simply use runtime PM.

No, they can't (I was talking about that at LinuxCon Japan last week).

I'll give more details in replies to the other messages in this thread.

Thanks,
Rafael
