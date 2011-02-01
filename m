From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC][PATCH] Power domains for platform bus type
Date: Tue, 01 Feb 2011 08:48:14 -0800
Message-ID: <87sjw7wvjl.fsf__15283.6859146648$1296579229$gmane$org@ti.com>
References: <201101300107.19389.rjw@sisk.pl> <871v3s3ahe.fsf@ti.com>
	<AANLkTinEsUOZQURXOfAVoTU5=k0mi8PC0_Gte6gACDFj@mail.gmail.com>
	<201102011158.46312.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201102011158.46312.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Tue, 1 Feb 2011 11:58:46 +0100")
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
Cc: LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

[...]

> Also, I'm going to move the power domain hook to the struct device level, so
> that we have:
>
> struct device {
>     ...
>     struct power_domain *domain;
>     ...
> };
>
> struct power_domain {
>     struct dev_pm_ops ops;
> };
>

Great, thanks.

Any opinion on my idea to name this 'struct dev_power_domain' to avoid
confusion with existing powerdomain structs in SoC code?  For example,
on OMAP we already have a 'struct powerdomain'.

Kevin
