From: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: [PATCH,
	post-2.6.36 regression fix] r8169: Fix runtime power management
Date: Thu, 9 Dec 2010 10:28:04 +0100
Message-ID: <20101209092804.GA4113__39246.9370076016$1291995925$gmane$org@electric-eye.fr.zoreil.com>
References: <201012090232.14375.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201012090232.14375.rjw@sisk.pl>
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
Cc: netdev@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, David Miller <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki <rjw@sisk.pl> :
[...]
> I noticed that one of the post-2.6.36 patches broke runtime PM of the
> r8169 on my MSI Wind test machine in such a way that the link was not
> brought up after reconnecting the network cable.
> 
> In the process of debugging the issue I realized that we only should
> invoke the runtime PM functions in rtl8169_check_link_status() when
> link change is reported and if we do so, the problem goes away.
> Moreover, this allows rtl8169_runtime_idle() to be simplified quite
> a bit.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Acked-by: Francois Romieu <romieu@fr.zoreil.com>

-- 
Ueimor
