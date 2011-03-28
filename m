From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [RFC][PATCH] PM / Platform: Remove __weak
 definitions of runtime PM callbacks
Date: Mon, 28 Mar 2011 20:05:16 +0900
Message-ID: <AANLkTi=JW-xdzE3tCMohVZ1A=2pk2WHD0WrDPU4FNaXA__27405.8571704247$1301310381$gmane$org@mail.gmail.com>
References: <201103270058.41632.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201103270058.41632.rjw@sisk.pl>
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
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun, Mar 27, 2011 at 8:58 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> Remove the __weak definitions of platform bus type runtime PM
> callbacks, make platform_dev_pm_ops point to the generic routines
> as appropriate and allow architectures using platform_dev_pm_ops to
> replace the runtime PM callbacks in that structure with their own
> set.
>
> Convert architectures providing its own definitions of the platform
> runtime PM callbacks to use the new mechanism.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Looking good, thanks Rafael. Tested on the sh7372 Mackerel board.

Acked-by: Magnus Damm <damm@opensource.se>
