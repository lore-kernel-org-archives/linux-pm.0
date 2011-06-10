From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V2] PM: OPP: introduce function to free
	cpufreq table
Date: Sat, 11 Jun 2011 00:06:34 +0200
Message-ID: <201106110006.34976.rjw__13862.1669299484$1307743704$gmane$org@sisk.pl>
References: <1306309406-3299-1-git-send-email-nm@ti.com>
	<8739k2wsdx.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <8739k2wsdx.fsf@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@ti.com>, Nishanth Menon <nm@ti.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, May 25, 2011, Kevin Hilman wrote:
> Nishanth Menon <nm@ti.com> writes:
> 
> > cpufreq table allocated by opp_init_cpufreq_table is better
> > freed by OPP layer itself. This allows future modifications to
> > the table handling to be transparent to the users.
> >
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> 
> Acked-by: Kevin Hilman <khilman@ti.com>

Applied to suspend-2.6/linux-next.

Thanks!
