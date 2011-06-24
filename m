From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] PM / Runtime: Update documentation of
	interactions with system sleep
Date: Fri, 24 Jun 2011 11:25:26 -0700
Message-ID: <87sjqz13zd.fsf__27652.5534027771$1308940031$gmane$org@ti.com>
References: <201106112223.04972.rjw@sisk.pl> <871uyljys6.fsf@ti.com>
	<201106230022.56462.rjw@sisk.pl> <201106231557.43653.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106231557.43653.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Thu, 23 Jun 2011 15:57:43 +0200")
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
Cc: linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> The documents describing the interactions between runtime PM and
> system sleep generally refer to the model in which the system sleep
> state is entered through a global firmware or hardware operation.
> As a result, some recommendations given in there are not entirely
> suitable for systems in which this is not the case.  Update the
> documentation take the existence of those systems into accout.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Looks good, thanks for updating this.

Reviewed-by: Kevin Hilman <khilman@ti.com>

Kevin
