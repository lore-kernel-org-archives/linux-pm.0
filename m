From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH V2] PM: OPP: introduce function to free
	cpufreq table
Date: Wed, 25 May 2011 11:24:10 -0700
Message-ID: <8739k2wsdx.fsf__7342.57073277167$1306347920$gmane$org@ti.com>
References: <1306309406-3299-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1306309406-3299-1-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Wed, 25 May 2011 00:43:26 -0700")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Nishanth Menon <nm@ti.com> writes:

> cpufreq table allocated by opp_init_cpufreq_table is better
> freed by OPP layer itself. This allows future modifications to
> the table handling to be transparent to the users.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Kevin Hilman <khilman@ti.com>
