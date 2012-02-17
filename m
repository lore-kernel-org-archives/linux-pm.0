From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM / QoS: unconditionally build the feature
Date: Fri, 17 Feb 2012 21:48:32 +0100
Message-ID: <201202172148.32168.rjw@sisk.pl>
References: <1328603646-2714-2-git-send-email-j-pihet@ti.com>
	<201202131641.10535.rjw@sisk.pl> <20120217192724.GC2707@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120217192724.GC2707@elf.ucw.cz>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Venkatesh Pallipadi <venki@google.com>, Mark Gross <markgross@thegnar.org>, linux-kernel@vger.kernel.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

On Friday, February 17, 2012, Pavel Machek wrote:
> On Mon 2012-02-13 16:41:10, Rafael J. Wysocki wrote:
> > On Monday, February 13, 2012, Jean Pihet wrote:
> > > The PM QoS feature depends on CONFIG_PM which depends on
> > > PM_SLEEP || PM_RUNTIME. This breaks CPU C-states with kernels
> > > not having these CONFIGs.
> > > 
> > > This patch allows the feature in all cases.
> > > 
> > > Signed-off-by: Jean Pihet <j-pihet@ti.com>
> > > Reported-by: Venkatesh Pallipadi <venki@google.com>
> > > Cc: Rafael J. Wysocki <rjw@sisk.pl>
> > > Cc: Mark Gross <markgross@thegnar.org>
> > 
> > Applied, but I modified the changelog (please have a look at the
> > linux-pm/pm-qos branch for details).
> 
> Is it good idea? For servers, power management / QoS is not
> neccessary... 

Yes, it is.  They surely use CPUidle.

Thanks,
Rafael
